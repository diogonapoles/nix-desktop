{
  pkgs,
  ...
}: {
  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wl-clipboard
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-wlr];
}
