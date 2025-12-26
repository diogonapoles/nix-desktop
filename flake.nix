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
        # Merge nixpkgs lib, home-manager lib, and custom lib
        lib = lib // (import ./lib { inherit inputs; });

        # Export custom packages
        packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });

        # Export overlays
        overlays = import ./overlays { inherit inputs; };

        # Export NixOS modules
        nixosModules.default = import ./modules/nixos;

        # Export home-manager modules
        homeManagerModules = import ./modules/home-manager;

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
