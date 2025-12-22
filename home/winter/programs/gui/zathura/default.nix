{
  pkgs,
  ...
}: {
  programs.zathura = {
    enable = true;

    options = {
      font = "JetBrainsMono Nerd Font 13";

      completion-bg = "rgb(60, 56, 54)";
      completion-fg = "rgb(131, 165, 152)";
      completion-highlight-bg = "rgb(131, 165, 152)";
      completion-highlight-fg = "rgb(251, 241, 199)";

      default-bg = "rgb(40, 40, 40)";
      default-fg = "rgb(60, 56, 54)";

      highlight-active-color = "rgba(131, 165, 152, 0.5)";
      highlight-color = "rgba(250, 189, 47, 0.5)";

      inputbar-bg = "rgb(40, 40, 40)";
      inputbar-fg = "rgb(251, 241, 199)";

      notification-bg = "rgb(40, 40, 40)";
      notification-fg = "rgb(251, 241, 199)";
      notification-error-bg = "rgb(40, 40, 40)";
      notification-error-fg = "rgb(251, 73, 52)";
      notification-warning-bg = "rgb(40, 40, 40)";
      notification-warning-fg = "rgb(251, 73, 52)";

      recolor-darkcolor = "rgb(235, 219, 178)";
      recolor-lightcolor = "rgb(40, 40, 40)";

      statusbar-bg = "rgb(80, 73, 69)";
      statusbar-fg = "rgb(189, 174, 147)";
    };

    mappings = {
      D = "toggle_page_mode";
      d = "scroll half-down";
      u = "scroll half-up";
    };
  };
}
