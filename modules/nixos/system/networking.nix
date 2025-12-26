{ lib, config, ... }:
let
  cfg = config.system.networking-custom;
in
{
  options.system.networking-custom = {
    enable = lib.mkEnableOption "Custom networking configuration";
  };

  config = lib.mkIf cfg.enable {
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

    networking.networkmanager.enable = true;
  };
}
