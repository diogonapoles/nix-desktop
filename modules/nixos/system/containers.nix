{ lib, config, ... }:
let
  cfg = config.system.containers-custom;
in
{
  options.system.containers-custom = {
    enable = lib.mkEnableOption "Container support (Docker and Podman)";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation = {
      docker.enable = true;
    };
  };
}
