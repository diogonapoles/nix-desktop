{ lib, config, ... }:
let
  cfg = config.theme.assets;
  homeDir = config.home.homeDirectory;
in
{
  options.theme.assets = {
    enable = lib.mkEnableOption "Theme assets configuration";

    wallpaper = lib.mkOption {
      type = lib.types.str;
      default = "${homeDir}/nixos/assets/current/current.png";
      description = "Path to wallpaper image";
    };

    lockscreen = lib.mkOption {
      type = lib.types.str;
      default = "${homeDir}/nixos/assets/forest-5.jpg";
      description = "Path to lockscreen background image";
    };

    profileImage = lib.mkOption {
      type = lib.types.str;
      default = "${homeDir}/nixos/assets/profile/logonord.png";
      description = "Path to profile image";
    };
  };

  config = lib.mkIf cfg.enable {
    # This module just provides configuration options
    # No actual configuration is set here
  };
}
