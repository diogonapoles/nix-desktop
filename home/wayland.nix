{ lib, config, pkgs, ... }:
let
  cfg = config.programs.wayland;
in
{
  options.programs.wayland = {
    enable = lib.mkEnableOption "Wayland environment configuration";

    nvidia.enable = lib.mkEnableOption "NVIDIA-specific Wayland settings";

    nvidia.backend = lib.mkOption {
      type = lib.types.enum [ "direct" "auto" ];
      default = "direct";
      description = "NVIDIA Direct rendering backend type";
    };

    toolkit.gdkScale = lib.mkOption {
      type = lib.types.int;
      default = 2;
      description = "GTK HiDPI scaling factor";
    };
  };

  config = lib.mkIf cfg.enable {
    # XDG Portal configuration
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    };

    home.sessionVariables = {
      # Wayland Session Configuration
      XDG_SESSION_TYPE = "wayland";

      # Browser & Electron Application Configuration
      NIXOS_OZONE_WL = "1";           # Chromium/Electron Wayland support
      MOZ_ENABLE_WAYLAND = "1";       # Firefox Wayland support
      MOZ_WEBRENDER = "1";            # Firefox WebRender
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      # Qt Configuration
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";

      # SDL Configuration
      SDL_VIDEODRIVER = "wayland";

      # GTK Configuration
      GDK_BACKEND = "wayland, x11";   # Prefer Wayland but fallback to X11
      GDK_SCALE = toString cfg.toolkit.gdkScale;

      # Java AWT window manager compatibility
      _JAVA_AWT_WM_NONREPARENTING = "1";
    } // lib.optionalAttrs cfg.nvidia.enable {
      # NVIDIA-specific environment variables
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = cfg.nvidia.backend;
      GBM_BACKEND = "nvidia-drm";
      WLR_DRM_NO_ATOMIC = 1;          # Workaround for wlroots compatibility
    };
  };
}
