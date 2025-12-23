{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../common/optional/nvidia.nix

    ../common/core
    ../common/users/winter

    ../common/optional/tuigreet.nix
    ../common/optional/pipewire.nix
    ../common/optional/boot.nix
    ../common/optional/networkmanager.nix
    ../common/optional/bluetooth.nix
    ../common/optional/locale-pt-PT.nix
    ../common/optional/keyboard-us.nix
    ../common/optional/base-packages.nix
    ../common/optional/containers.nix

    ../common/optional/gamemode.nix
    ../common/optional/gaming.nix
  ];

  networking = {
    hostName = "apollo";
  };

  system.stateVersion = "25.11";
}
