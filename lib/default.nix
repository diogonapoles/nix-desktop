{ inputs, ... }:
let
  helpers = import ./helpers.nix { inherit (inputs.nixpkgs) lib; };
in
{
  inherit (helpers)
    ifTheyExist
    mkRelativeToRoot
    mkIfElse;
}
