{ config, ... }: {
  services.mako = {
    enable = true;
    settings = {
      icon-path = "${config.stylix.icons.package}/share/icons/${
        if config.stylix.polarity == "dark"
        then config.stylix.icons.dark
        else config.stylix.icons.light
      }";
      padding = "10,20";
      anchor = "top-center";
      width = 400;
      height = 150;
      border-size = 2;
      default-timeout = 12000;
      border-radius = 10;
      layer = "overlay";
      max-history = 50;
    };
  };
}
