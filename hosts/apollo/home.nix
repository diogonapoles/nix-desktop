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

    # shell
    ../../home/shell/zsh

    # terminal programs
    ../../home/terminal/ghostty
    ../../home/terminal/yazi
    ../../home/terminal/btop
    ../../home/terminal/fastfetch

    # wm and companions
    ../../home/wm/hyprland
    ../../home/wm/waybar
    ../../home/wm/hyprlock
    ../../home/wm/rofi
    ../../home/wm/hypridle
    ../../home/wm/swayosd
    ../../home/wm/mako

    # gui apps
    ../../home/apps/firefox
    ../../home/apps/discord
    ../../home/apps/obsidian
    ../../home/apps/zathura
    ../../home/apps/misc.nix
  ];

  programs.wayland = {
    enable = true;
    nvidia.enable = true;
    toolkit.gdkScale = 2;
  };

  wayland.windowManager.hyprland.settings.monitor =
    "DP-3, highres@highrr, auto, 1.5, bitdepth,10";

  home.sessionVariables.NH_FLAKE = "${homeDir}/nixos";
}
