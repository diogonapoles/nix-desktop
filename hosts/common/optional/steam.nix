{
  pkgs, 
  config,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];

    gamescopeSession.enable = true;
    protontricks.enable = true;
    extest.enable = true;

    remotePlay.openFirewall = true;  # Automatically opens ports
    dedicatedServer.openFirewall = true;

    fontPackages = [
      pkgs.wqy_zenhei # Need by steam for Chinese
    ];
  };
}
