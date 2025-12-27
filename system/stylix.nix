{ pkgs, ... }: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";

    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
