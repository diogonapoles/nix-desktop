{ pkgs, ... }: {
  # Nix configuration
  nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

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
