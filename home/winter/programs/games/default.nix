{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    mangohud
    protonup-qt
    winetricks
    umu-launcher
    bbe
    heroic
    gamescope
    gamemode
    lutris
    dualsensectl
  ];
}
