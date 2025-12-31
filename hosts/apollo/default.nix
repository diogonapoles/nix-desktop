{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix

    ../common/core.nix
    ../common/users/winter.nix

    ../../system/hardware/nvidia.nix
    ../../system/hardware/bluetooth.nix

    ../../system/services/pipewire.nix
    ../../system/services/greetd.nix
    ../../system/services/display-manager.nix
    ../../system/services/home-manager.nix

    ../../system/boot.nix
    ../../system/networking.nix
    ../../system/locale.nix
    ../../system/containers.nix
    ../../system/packages.nix
    ../../system/memory.nix
    ../../system/gaming.nix
    # ../../system/remote-desktop.nix
    ../../system/stylix.nix
    ../../system/coolercontrol.nix
  ];

  home-manager.users.winter = ./home.nix;


  services.hardware = {
    openrgb = {
      enable = true;
    };
  };

  stylix-custom = {
    enable = true;
    colorscheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    polarity = "dark";

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    icons = {
      package = pkgs.papirus-icon-theme.override { color = "green"; };
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };

  security.pam.services.hyprlock = {};

  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "apollo";
  system.stateVersion = "25.11";
}
