{ pkgs, ... }: {
  stylix.fonts = {
    sansSerif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    serif = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
    hyprlock.enable = false;
    ghostty = {
      enable = true;
      fonts.enable = false;
    };

    gtk.enable = true;
    gnome.enable = true;
    qt.enable = true;

    btop.enable = true;
    fzf.enable = false;
    zathura.enable = true;

    firefox.enable = false;
    vesktop.enable = true;
  };
}
