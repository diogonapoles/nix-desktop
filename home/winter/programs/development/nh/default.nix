{
  pkgs,
  config,
  ...
}: {
  programs.nh = {
    enable = true;

    flake = "/home/${config.home.username}/nix";

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };
}
