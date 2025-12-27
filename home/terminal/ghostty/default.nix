{ 
  pkgs, 
  ... 
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Gruvbox Dark";
      
      font-family = "FiraCode Nerd Font Mono";
      font-style = "Regular";
      font-size = 10;
      
      window-theme = "ghostty";
      window-padding-x = 10;
      window-padding-y = 10;
      confirm-close-surface = false;
      background-opacity = 0.80;
      resize-overlay = "never";
      gtk-toolbar-style = "flat";
      
      cursor-style = "block";
      cursor-style-blink = false;
      
      shell-integration-features = "no-cursor,ssh-env";
      
      keybind = [
        "shift+insert=paste_from_clipboard"
        "control+insert=copy_to_clipboard"
        "shift+enter=text:\\x1b\\r"
      ];
    };
  };

  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "ghostty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "ghostty.desktop";
    };
  };
}
