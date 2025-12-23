{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [ ] ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = lib.mkDefault "winter";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "22.11";
    sessionPath = ["$HOME/.local/bin"];
  };
}
