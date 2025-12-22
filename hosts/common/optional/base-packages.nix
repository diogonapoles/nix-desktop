{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    nix-search-cli
  ];
}
