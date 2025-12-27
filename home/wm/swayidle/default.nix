{
  pkgs,
  ...
}: {
  services.swayidle = {
    enable = true;

    timeouts = [
      { 
        timeout = 180;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }

      {
        timeout = 185;
        command = "${pkgs.hyprlock}/bin/hyprlock";
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
