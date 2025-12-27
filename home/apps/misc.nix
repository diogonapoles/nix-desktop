{
  pkgs,
  config,
  ...
}: {
  # NH (NixOS helper)
  programs.nh = {
    enable = true;

    flake = "/home/${config.home.username}/nixos";

    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 7d";
    };
  };

  # Additional packages
  home.packages = with pkgs; [
    impala
    claude-code          # CLI tool for AI assistance
    wpa_supplicant_gui   # WiFi GUI
  ];

  # Lazydocker
  programs.lazydocker.enable = true;
}
