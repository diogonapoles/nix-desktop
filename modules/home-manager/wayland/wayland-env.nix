{ lib, config, ... }:
let
  cfg = config.programs.wayland-env;
in
{
  options.programs.wayland-env = {
    enable = lib.mkEnableOption "Wayland session and browser environment variables";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      # Wayland Session Configuration
      XDG_SESSION_TYPE = "wayland";

      # Browser & Electron Application Configuration

      # Chromium/Electron Wayland support
      NIXOS_OZONE_WL = "1";

      # Firefox Wayland support
      MOZ_ENABLE_WAYLAND = "1";

      # Firefox WebRender
      MOZ_WEBRENDER = "1";

      # Electron Wayland auto-detection
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
