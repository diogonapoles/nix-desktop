{
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    font = "JetBrainsMono Nerd Font regular 13";

    theme = ./gruvbox.rasi;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "Applications";
      display-run = "Run";
      display-window = "Windows";
    };
  };

  xdg.configFile."rofi/powermenu/theme.rasi".source = ./powermenu/theme.rasi;
  xdg.configFile."rofi/powermenu/powermenu.rasi".source = ./powermenu/powermenu.rasi;
}
