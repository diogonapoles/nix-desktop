{
  pkgs,
  config,
  lib,
  outputs,
  ...
}: {
  users.users.winter = {
    isNormalUser = true;
    shell = pkgs.zsh;  
    extraGroups = outputs.lib.ifTheyExist [
      "audio"
      "docker"
      "git"
      "networkmanager"
      "video"
      "wheel"
    ] config;

    packages = [pkgs.home-manager];
  };

  home-manager.users.winter = ../../../../home/winter/apollo.nix;

  security.pam.services = {
    hyprlock = {};
  };
}
