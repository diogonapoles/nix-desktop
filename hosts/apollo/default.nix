{
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix

    ../common/core
    ../common/users/winter.nix

    ../common/optional/bluetooth.nix
    ../common/optional/coolercontrol.nix
    ../common/optional/gaming.nix
    ../common/optional/networking.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix

    ../common/optional/drivers/nvidia-gpu.nix
  ];

  networking.hostName = "apollo";
  home-manager.users.winter = ./home.nix;

  nixpkgs = {
    overlays = [
      inputs.nix-cachyos-kernel.overlays.default
    ];
  };
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    nix-search-cli
  ];

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

  system.stateVersion = "25.11";
}
