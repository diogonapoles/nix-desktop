{ lib, config, ... }:
let
  cfg = config.services.pipewire-custom;
in
{
  options.services.pipewire-custom = {
    enable = lib.mkEnableOption "PipeWire audio server";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    services.pulseaudio.enable = false;
  };
}
