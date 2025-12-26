{ lib, config, ... }:
let
  cfg = config.monitors;
in
{
  options.monitors = {
    enable = lib.mkEnableOption "Monitor configuration";

    primary = lib.mkOption {
      type = lib.types.str;
      default = "DP-3";
      description = "Primary monitor name";
    };

    hyprlandConfig = lib.mkOption {
      type = lib.types.str;
      default = "highres@highrr, auto, 1.5, bitdepth,10";
      description = "Hyprland monitor configuration string";
    };
  };

  config = lib.mkIf cfg.enable {
    # This module just provides configuration options
    # No actual configuration is set here
  };
}
