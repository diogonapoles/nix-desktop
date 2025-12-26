{ lib, config, pkgs, ... }:
let
  cfg = config.services.tuigreet-custom;
in
{
  options.services.tuigreet-custom = {
    enable = lib.mkEnableOption "TUI greeter for greetd";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
        };
      };
    };
  };
}
