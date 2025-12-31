{ pkgs, inputs, ... }: {
  nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-cachyos-kernel.overlays.default
    ];
  };

  # Firmware
  hardware.enableRedistributableFirmware = true;

  # Security
  security.pam.services = {
    greetd.fprintAuth = true;
    sudo.fprintAuth = true;
    hyprlock.fprintAuth = true;
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function (action, subject) {
        if (action.id == "net.reactivated.fprint.device.enroll") {
            return polkit.Result.YES;
        }
    });
  '';

  # Core programs
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
}
