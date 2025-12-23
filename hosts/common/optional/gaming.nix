{
  pkgs, 
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    winetricks
    umu-launcher
    bbe
    heroic
    gamescope
    lutris
    dualsensectl
  ];

  programs = {
    # steam: gamemoderun %command% 
    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 10;
        };

        cpu = {
          park_cores = "no";
          pin_cores = "no";
        };

        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          nv_powermizer_mode = 1;
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];

      gamescopeSession.enable = true;
      protontricks.enable = true;
      extest.enable = true;

      remotePlay.openFirewall = true;  # Automatically opens ports
      dedicatedServer.openFirewall = true;

      fontPackages = [
        pkgs.wqy_zenhei # Need by steam for Chinese
      ];
    };
  };
}
