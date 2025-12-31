{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    openlinkhub
  ];

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  systemd.user.services.openrgb = {
    description = "OpenRGB - RGB lighting control";

    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --startminimized";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  systemd.services.openlinkhub = {
    description = "Open source interface for iCUE LINK System Hub, Corsair AIOs and Hubs";

    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [ 
      pciutils
      usbutils
    ];

    serviceConfig = {
      StateDirectory = "OpenLinkHub";
      WorkingDirectory = "/var/lib/OpenLinkHub";
      ExecStart = "${pkgs.openlinkhub}/bin/OpenLinkHub";

      Restart = "always";
      RestartSec = 5;
    };
  };
}
