{
  config, 
  lib, 
  pkgs, 
  ...
}: {
  users.users.greeter = {
    extraGroups = ["seat"];
  };

  services = {
    seatd.enable = true;
    # greetd configuration is now handled by programs.regreet
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
