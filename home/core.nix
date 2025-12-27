{
  lib,
  config,
  ...
}: {
  options.home.exportedSessionPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    description = "Packages to export as display manager sessions";
  };

  config = {
    programs.home-manager.enable = true;

    home = {
      username = lib.mkDefault "winter";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "22.11";
      sessionPath = ["$HOME/.local/bin"];
    };
  };
}
