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

    # Common settings shared across potential hosts
    ../common/core.nix
    ../common/users/winter.nix

    # System modules (imported directly - active when imported)
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

  # Home-manager configuration
  home-manager.users.winter = ./home.nix;

  # PAM configuration for hyprlock
  security.pam.services.hyprlock = {};

  # CPU Performance Governor
  powerManagement.cpuFreqGovernor = "performance";

  networking.hostName = "apollo";
  system.stateVersion = "25.11";
}
