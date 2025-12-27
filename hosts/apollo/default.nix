{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix
    ../common/global
    ../common/users/winter
  ];

  hardware.nvidia-custom.enable = true;
  hardware.bluetooth-custom.enable = true;

  services.pipewire-custom.enable = true;
  services.tuigreet-custom.enable = true;

  system.boot-custom.enable = true;
  system.networking-custom.enable = true;
  system.locale-custom.enable = true;
  system.keyboard-custom.enable = true;
  system.containers-custom.enable = true;
  system.base-packages.enable = true;
  system.remote-desktop-custom.enable = true;
  system.stylix-custom.enable = true;

  gaming.steam-custom.enable = true;

  networking = {
    hostName = "apollo";
  };

  system.stateVersion = "25.11";
}
