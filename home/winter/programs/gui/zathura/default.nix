{
  pkgs,
  ...
}: {
  programs.zathura = {
    enable = true;

    options = {
      font = "JetBrainsMono Nerd Font 13";
    };

    mappings = {
      D = "toggle_page_mode";
      d = "scroll half-down";
      u = "scroll half-up";
    };
  };
}
