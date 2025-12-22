{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [] ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "winter";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "/home/${config.home.username}/nix";

      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      GBM_BACKEND = "nvidia-drm";
      WLR_DRM_NO_ATOMIC = 1;

      NIXOS_OZONE_WL = "1"; # for any ozone-based browser & electron apps to run on wayland
      MOZ_ENABLE_WAYLAND = "1"; # for firefox to run on wayland
      MOZ_WEBRENDER = "1";
      # enable native Wayland support for most Electron apps
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      # misc
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland, x11";
      XDG_SESSION_TYPE = "wayland";
      GDK_SCALE = "2";
    };
  };
}
