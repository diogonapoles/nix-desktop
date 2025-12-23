{
  pkgs,
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
}
