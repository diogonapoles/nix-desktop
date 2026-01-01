# This file (and the global directory) holds config that i use on all hosts
{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./dconf.nix
    ./display-manager.nix
    ./locale.nix
    ./memory.nix
    ./nix-ld.nix
    ./nix.nix
    ./stylix.nix
    ./systemd-initrd.nix
    ./zsh.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  # increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  services.speechd.enable = false;
}
