{
  pkgs,
  config,
  outputs,
  ...
}:
{
  users.users.winter = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = outputs.lib.ifTheyExist [
      "audio"
      "i2c"
      "docker"
      "git"
      "networkmanager"
      "network"
      "video"
      "wheel"
      "gamemode"
    ] config;

    packages = [ pkgs.home-manager ];
  };

  security.pam.services.hyprlock = { };
}
