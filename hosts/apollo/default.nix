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
    ../../system/remote-desktop.nix
    ../../system/gaming.nix
    ../../system/stylix.nix
  ];

  home-manager.users.winter = ./home.nix;

  security.pam.services.hyprlock = {};

  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "apollo";
  system.stateVersion = "25.11";
}
