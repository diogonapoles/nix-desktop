{ lib, config, ... }:
let
  cfg = config.programs.stylix-targets;
in
{
  options.programs.stylix-targets = {
    enable = lib.mkEnableOption "Stylix target configuration for home-manager applications";
  };

  config = lib.mkIf cfg.enable {
    stylix.targets = {
      # Disable styling for applications with custom themes
      waybar.enable = false;
      rofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      ghostty.enable = false;

      # Disable GTK and GNOME theming (using custom themes)
      gtk.enable = false;
      gnome.enable = false;

      # Enable styling for Qt applications
      qt.enable = true;

      # Terminal and CLI tools
      btop.enable = true;
      fzf.enable = true;
      zathura.enable = true;

      # Browsers
      firefox.enable = true;
    };
  };
}
