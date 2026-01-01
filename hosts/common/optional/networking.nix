{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
      59010
      59011
      8080
    ];
    allowedUDPPorts = [
      59010
      59011
    ];
  };

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false; # let networkmanager handle this
      };
      Network = {
        EnableIPv6 = true;
        RoutePriorityOffset = 300;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };
}
