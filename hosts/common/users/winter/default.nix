{ 
  pkgs, 
  config, 
  lib, 
  ... 
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.winter = {
    isNormalUser = true;
    shell = pkgs.zsh;  
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "networkmanager"
      "video"
      "wheel"
    ];

    packages = [pkgs.home-manager];
  };

  home-manager.users.winter = ../../../../home/winter/apollo.nix;

  security.pam.services = {
    hyprlock = {};
  };
}
