{ pkgs, config, ... }: {
  # NixOS helper
  programs.nh = {
    enable = true;
    flake = "/home/${config.home.username}/nixos";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  programs.lazydocker.enable = true;
}
