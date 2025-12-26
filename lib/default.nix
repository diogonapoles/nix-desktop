{ inputs, ... }:
let
  helpers = import ./helpers.nix { inherit (inputs.nixpkgs) lib; };
in
{
  # Re-export all helper functions
  inherit (helpers)
    ifTheyExist
    mkRelativeToRoot
    mkIfElse;
}
