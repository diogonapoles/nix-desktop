{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swaybg
    hyprshot  # Screenshot tool
  ];

  xdg.portal = {
    extraPortals = [(pkgs.xdg-desktop-portal-hyprland.override {hyprland = config.wayland.windowManager.hyprland.package;})];
    config.hyprland = {
      default = [ "hyprland" "gtk" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = { 
      enable = true; 
    };

    settings = {
      xwayland = {
        force_zero_scaling = true;
      };

      ecosystem = {
        no_update_news = true;
      };

      general = {
        gaps_in = 2;
        gaps_out = 7;
        border_size = 2;
        "col.active_border" = "rgb(${config.lib.stylix.colors.base05})";
        "col.inactive_border" = "rgb(${config.lib.stylix.colors.base03})";
        resize_on_border = false;
        no_border_on_floating = false;
        allow_tearing = true;
        layout = "dwindle";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 0.95;

        shadow = {
          enabled = false;
        };

        blur = {
          enabled = true;
          size = 6;
          passes = 4;
          new_optimizations = true;
          contrast = 1.0;
          brightness = 1.0;
          noise = 0.0065;
          vibrancy = 0.2;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "easeOutQuint, 0.22, 1, 0.36, 1"
          "easeOutQuart, 0.25, 1, 0.5, 1"
        ];

        animation = [
          "windows, 1, 2.5, easeOutQuint, slide"
          "windowsIn, 1, 2.5, easeOutQuint, slide"
          "windowsOut, 1, 2.5, easeOutQuart, slide"
          "windowsMove, 1, 1.8, easeOutQuart"
          "workspaces, 1, 3.5, easeOutQuint, slide"
          "workspacesIn, 1, 3.5, easeOutQuint, slide"
          "workspacesOut, 1, 3.5, easeOutQuint, slide"
        ];
      };

      input = {
        kb_layout = "us";
        kb_options = "ctrl:nocaps";
        repeat_rate = 35;
        repeat_delay = 200;
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      cursor = {
        inactive_timeout = 30;
        no_hardware_cursors = true;
      };

      gesture = "3, horizontal, workspace";

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
        exit_window_retains_fullscreen = true;
      };

      "$terminal" = "ghostty";
      "$browser" = "firefox";
      "$menu" = "rofi -show drun";
      "$fileManager" = "ghostty -e yazi -- --class=center-float-mini";
      "$obsidian" = "obsidian --disable-gpu --enable-wayland-ime";
      # "$swaync" = "uwsm-app -- swaync-client --toggle-panel";
      "$lock" = "hyprlock";
      "$powermenu" = "powermenu";

      bind = [
        "SUPER, Return, exec, $terminal"
        "SUPER, B, exec, $browser"
        "SUPER, Space, exec, $menu"
        "SUPER, E, exec, $fileManager"
        "SUPER SHIFT, O, exec, $obsidian"
        # "SUPER, Z, exec, $swaync"
        "SUPER, X, exec, $lock"
        "SUPER, Escape, exec, $powermenu"

        "SUPER SHIFT, R, exec, pkill waybar && waybar &"

        "SUPER, Q, killactive,"
        "SUPER, V, togglefloating,"
        "SUPER, F, fullscreen, 0"
        "SUPER, M, fullscreen, 1"
        "SUPER, P, pseudo,"
        "SUPER, D, togglesplit,"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER SHIFT, H, swapwindow, l"
        "SUPER SHIFT, L, swapwindow, r"
        "SUPER SHIFT, K, swapwindow, u"
        "SUPER SHIFT, J, swapwindow, d"

        "SUPER ALT, H, resizeactive, -40 0"
        "SUPER ALT, L, resizeactive, 40 0"
        "SUPER ALT, K, resizeactive, 0 -40"
        "SUPER ALT, J, resizeactive, 0 40"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"

        "SUPER SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, movetoworkspacesilent, 6"  
        "SUPER SHIFT, 8, movetoworkspacesilent, 6"  
        "SUPER SHIFT, 9, movetoworkspacesilent, 6"  

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        ", PRINT, exec, hyprshot -m output"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      "$osdclient" = "swayosd-client --monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')\"";

      bindld = [
        ",XF86AudioRaiseVolume, Volume up, exec, $osdclient --output-volume raise"
        ",XF86AudioLowerVolume, Volume down, exec, $osdclient --output-volume lower"          
        "ALT,XF86AudioRaiseVolume, Volume up precise, exec, $osdclient --output-volume +1"   
        "ALT,XF86AudioLowerVolume, Volume down precise, exec, $osdclient --output-volume -1" 
                                                                                            
        ",XF86AudioMute, Mute, exec, $osdclient --output-volume mute-toggle"                  
        ",XF86AudioMicMute, Mute microphone, exec, $osdclient --input-volume mute-toggle"     
                                                                                            
        ",XF86AudioNext, Next track, exec, $osdclient --playerctl next"                       
        ",XF86AudioPause, Pause, exec, $osdclient --playerctl play-pause"                     
        ",XF86AudioPlay, Play, exec, $osdclient --playerctl play-pause"                       
        ",XF86AudioPrev, Previous track, exec, $osdclient --playerctl previous"               
      ];

      "$center-float-large" = "class:^(center-float-large)$|^(.*Geeqie.*)$|^(.*geeqie.*)$|^(.*celluloid.*)$|^(.*mpv.*)$|^(.*File Upload.*)$|^(.*imv.*)$";
      "$center-float" = "class:^(center-float)$|^(.*file-roller.*)$|^(.*FileRoller.*)$|^(.*blueman-manager.*)$|^(.*blueberry.py.*)$";
      "$center-float-title" = "title:^(.*Open Folder.*)$|^(.*Open File.*)$|^(.*Save File.*)$|^(.*Save Folder.*)$|^(.*Save Image.*)$|^(.*Library.*)$|^(.*Save As.*)$|^(.*Open As.*)$|^(.*Volume Control.*)$|^(.*Settings.*)$|^(.*Warning.*)$|^(.*nmtui.*)$|^(update.sh)$";
      "$center-float-mini" = "class:^(center-float-mini)$|^(.*galculator.*)$|^(.*ytdlp-gui.*)$";

      windowrule = [
        "float, $center-float-large"
        "size 70% 70%, $center-float-large"
        "center 1, $center-float-large"

        "float, $center-float"
        "size 50% 50%, $center-float"
        "center 1, $center-float"

        "float, $center-float-title"
        "size 50% 50%, $center-float-title"
        "center 1, $center-float-title"

        "float, $center-float-mini"
        "size 30% 40%, $center-float-mini"
        "center 1, $center-float-mini"

        "float, class:steam"
        "center, class:steam, title:Steam"
        "opacity 1 1, class:steam"
        "size 1100 700, class:steam, title:Steam"
        "size 460 800, class:steam, title:Friends List"
        "idleinhibit fullscreen, class:steam"

        # allow tearing
        "immediate, class:^(steam_app).*"
        "immediate, class:^(gamescope).*"

        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        "workspace 2, class:firefox"
        "workspace 3, class:discord"

        "tag +games, class:^(gamescope)$"
        "tag +games, class:^(steam_app_\d+)$"
        "tag +gamestore, class:^([Ss]team)$"
        "tag +gamestore, title:^([Ll]utris)$"
        "tag +gamestore, class:^(com.heroicgameslauncher.hgl)$"
        "noblur, tag:games*"
      ];

      # Layer rules
      layerrule = [
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.1, swaync-control-center"
        "ignorealpha 0.1, swaync-notification-window"
      ];

      "exec-once" = [
        "swaybg -i ${config.home.homeDirectory}/nixos/assets/1377788.png -m fill"
        "waybar"
        # "uwsm-app -- swaync"
        # "uwsm-app -- wl-paste --watch cliphist store"
      ];

      # Monitor config is set in hosts/apollo/home.nix
    };
  };

  home.exportedSessionPackages = [
    config.wayland.windowManager.hyprland.package
  ];
}
