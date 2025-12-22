{lib, config, ...}: {
  options = {
    home.exportedSessionPackages = lib.mkOption {
      type = lib.types.listOf lib.types.pathInStore;
      default = [];
      description = "List of session packages to export to the display manager";
    };
  };
}
