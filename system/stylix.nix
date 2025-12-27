{ pkgs, ... }: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    polarity = "dark";
    # image = /path/to/wallpaper.jpg;

    targets = {
      gtk.enable = false;
    };

    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
