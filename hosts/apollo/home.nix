{
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    ../../home
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
