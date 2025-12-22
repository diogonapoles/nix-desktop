{
    description = "winter nixos";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        systems.url = "github:nix-systems/default-linux";

        hardware.url = "github:nixos/nixos-hardware";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
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
        inherit lib;
        homeManagerModules = import ./modules/home-manager;

        templates = {
            go = {
                path = ./templates/go;
                description = "Basic Go development environment with direnv";
            };
        };

        nixosConfigurations = {
            worm = lib.nixosSystem {
                modules = [./hosts/worm];
                specialArgs = {
                    inherit inputs outputs;
                };
            };
        };
    };
}
