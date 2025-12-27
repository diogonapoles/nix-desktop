{ lib, config, pkgs, ... }:
let
  cfg = config.system.stylix-custom;
in
{
  options.system.stylix-custom = {
    enable = lib.mkEnableOption "Stylix system-wide theming with Gruvbox";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      polarity = "dark";
      # image = /path/to/wallpaper.jpg;

      targets = {
        gtk.enable = false;
      };

      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };
    };
  };
}
