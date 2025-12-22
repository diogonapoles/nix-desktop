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
    ./programs/development
    ./programs/gui
    ./programs/games

    ./scripts
  ];
}
