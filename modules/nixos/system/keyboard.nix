{ lib, config, ... }:
let
  cfg = config.system.keyboard-custom;
in
{
  options.system.keyboard-custom = {
    enable = lib.mkEnableOption "Custom keyboard configuration";

    layout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Keyboard layout";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.xkb = {
      layout = cfg.layout;
      variant = "";
    };
  };
}
