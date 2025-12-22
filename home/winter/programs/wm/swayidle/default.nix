{
  pkgs,
  ...
}: {
  services.swayidle = {
    enable = true;

    timeouts = [
      { 
        timeout = 180;
        command = "${pkgs.libnotify}/bin/notify-send 'Suspending in 5 seconds' -t 5000";
      }

      {
        timeout = 185;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];
  };
}
