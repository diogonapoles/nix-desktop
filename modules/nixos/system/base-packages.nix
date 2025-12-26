{ lib, config, pkgs, ... }:
let
  cfg = config.system.base-packages;
in
{
  options.system.base-packages = {
    enable = lib.mkEnableOption "Base system packages";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
      wget
      neovim
      nix-search-cli
    ];
  };
}
