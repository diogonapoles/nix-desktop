{
  description = "A Nix-flake-based Go development environment";

  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

  outputs = { self, nixpkgs }:
    let
      goVersion = 24;

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems (system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlays.default ];
            };
          }
        );
    in
    {
      overlays.default = final: prev: {
        go = final."go_1_${toString goVersion}";
      };

      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            go              # Version controlled by overlay above
            gotools         # goimports, godoc, etc.
            golangci-lint   # Linter
          ];

          shellHook = ''
            echo "🚀 Go ${pkgs.go.version} development environment"
            echo "   Commands: go run . | go test ./... | go build"
          '';
        };
      });
    };
}
