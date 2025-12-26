{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./core

    ./wm/hyprland
    ./programs/system
    ./programs/wm
    ./programs/cli
    ./programs/gui

    ./scripts
  ];

  # Enable environment variable modules
  hardware.nvidia-env.enable = true;
  programs.wayland-env.enable = true;
  programs.toolkit-env.enable = true;

  # Enable configuration modules
  theme.assets.enable = true;
  monitors.enable = true;

  # Path to NixOS flake configuration directory
  home.sessionVariables.NH_FLAKE = "/home/${config.home.username}/nixos";
}
