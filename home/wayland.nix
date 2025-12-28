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
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
    };

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";

      # browser & electron application configuration
      NIXOS_OZONE_WL = "1";           # chromium/electron wayland support
      MOZ_ENABLE_WAYLAND = "1";       # firefox wayland support
      MOZ_WEBRENDER = "1";            # firefox webRender
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";

      SDL_VIDEODRIVER = "wayland";

      GDK_BACKEND = "wayland, x11";   
      GDK_SCALE = toString cfg.toolkit.gdkScale;

      # java AWT window manager compatibility
      _JAVA_AWT_WM_NONREPARENTING = "1";
    } // lib.optionalAttrs cfg.nvidia.enable {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = cfg.nvidia.backend;
      GBM_BACKEND = "nvidia-drm";
      WLR_DRM_NO_ATOMIC = 1;          # Workaround for wlroots compatibility
    };
  };
}
