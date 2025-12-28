{ pkgs, ... }: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme.override { color = "green"; };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
