{ ... }: {
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
}
