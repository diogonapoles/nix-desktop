{
    description = "winter nixos";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        systems.url = "github:nix-systems/default-linux";
        hardware.url = "github:nixos/nixos-hardware";

        stylix = {
          url = "github:nix-community/stylix";
          inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    outputs = { 
        self, 
        nixpkgs, 
        home-manager, 
        systems,
        ... 
    } @ inputs: let
        inherit (self) outputs;
        lib = nixpkgs.lib // home-manager.lib;
        forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
        pkgsFor = lib.genAttrs (import systems) (
            system:
                import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                }
        );
    in {
        lib = lib // (import ./lib.nix { inherit lib; });

        nixosConfigurations = {
            apollo = lib.nixosSystem {
                modules = [./hosts/apollo];
                specialArgs = {
                    inherit inputs outputs;
                };
            };
        };
    };
}
