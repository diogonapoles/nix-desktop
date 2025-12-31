{
  pkgs,
  config,
  outputs,
  ...
}: {
  users.users.winter = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = outputs.lib.ifTheyExist [
      "audio"
      "i2c"
      "docker"
      "git"
      "networkmanager"
      "video"
      "wheel"
      "gamemode"
    ] config;

    packages = [ pkgs.home-manager ];
  };
}
