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
    # ../../system/services/openrgb.nix

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

  # environment.systemPackages = [ pkgs.i2c-tools ];
  # boot.kernelModules = [ "12c-dev" "12c-piix4" ];
  # services.hardware.openrgb = {
  #   enable = true;
  #   motherboard = "amd";
  #   # package = pkgs.openrgb-with-all-plugins; # enable all plugins
  # };
  # services.udev.extraRules = ''
  #   SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="8297", TAG+="uaccess", TAG+="Gigabyte_RGB_Fusion_2_USB"
  #   SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="8950", TAG+="uaccess", TAG+="Gigabyte_RGB_Fusion_2_USB"
  #   SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="5702", TAG+="uaccess", TAG+="Gigabyte_RGB_Fusion_2_USB"
  #   SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="5711", TAG+="uaccess", TAG+="Gigabyte_RGB_Fusion_2_USB"
  #   SUBSYSTEMS=="usb|hidraw", ATTRS{idVendor}=="1b1c", ATTRS{idProduct}=="0c3f", TAG+="uaccess", TAG+="Corsair_iCUE_Link_System_Hub"
  # '';

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
