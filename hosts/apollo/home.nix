{
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    ../../home/core.nix
    ../../home/wayland.nix
    ../../home/git.nix
    ../../home/stylix.nix
    ../../home/fonts.nix
    ../../home/gtk.nix
    ../../home/scripts.nix

    # Shell
    ../../home/shell/zsh

    # Terminal programs
    ../../home/terminal/ghostty
    ../../home/terminal/yazi
    ../../home/terminal/btop
    ../../home/terminal/fastfetch

    # WM and companions
    ../../home/wm/hyprland
    ../../home/wm/waybar
    ../../home/wm/hyprlock
    ../../home/wm/rofi
    ../../home/wm/swayidle
    ../../home/wm/swayosd

    # GUI Apps
    ../../home/apps/firefox
    ../../home/apps/discord
    ../../home/apps/obsidian
    ../../home/apps/zathura
    ../../home/apps/misc.nix
  ];

  # Wayland environment
  programs.wayland = {
    enable = true;
    nvidia.enable = true;
    toolkit.gdkScale = 2;
  };

  # Assets (from assets.nix)
  stylix.image = ../../assets/1377788.png;

  # Monitor config (from monitors.nix)
  wayland.windowManager.hyprland.settings.monitor =
    "DP-3, highres@highrr, auto, 1.5, bitdepth,10";

  # Path to NixOS flake configuration directory
  home.sessionVariables.NH_FLAKE = "${homeDir}/nixos";
}
