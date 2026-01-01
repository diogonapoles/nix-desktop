{
  pkgs,
  config,
  ...
}:
{
  gtk.enable = true;

  xresources.properties = {
    # dpi for Xorg's font
    "Xft.dpi" = 150;
    # or set a generic dpi
    "*.dpi" = 150;
  };
}
