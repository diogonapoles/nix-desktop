{
  imports = [
    # Core system modules (from hosts/common/core)
    ./nix.nix
    ./nixpkgs.nix
    ./firmware.nix
    ./security.nix
    ./zsh.nix
    ./nix-ld.nix
    ./swappiness.nix
    ./dconf.nix

    # Optional system modules (from hosts/common/optional)
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./keyboard.nix
    ./containers.nix
    ./base-packages.nix
  ];
}
