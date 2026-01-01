{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.greeter = {
    extraGroups = [ "seat" ];
  };
  services = {
    seatd.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
        };
      };
    };

    displayManager = {
      enable = true;
      # collect available sessions
      sessionPackages = lib.flatten (
        lib.mapAttrsToList (
          _: v: if v ? home.exportedSessionPackages then v.home.exportedSessionPackages else [ ]
        ) config.home-manager.users
      );
    };
  };
}
