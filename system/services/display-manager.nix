{
  config,
  lib,
  ...
}: {
  users.users.greeter = {
    extraGroups = ["seat"];
  };

  services = {
    seatd.enable = true;
    displayManager = {
      enable = true;
      # collect available sessions
      sessionPackages = lib.flatten (lib.mapAttrsToList
        (_: v: if v ? home.exportedSessionPackages
               then v.home.exportedSessionPackages
               else [])
        config.home-manager.users);
    };
  };
}
