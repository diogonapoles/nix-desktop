{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.waybar = {
    Unit = {
      StartLimitBurst = 30;

      X-Restart-Triggers = lib.mkForce [];
      X-SwitchMethod = "reload";
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 4;
        margin-left = 8;
        margin-right = 8;
        height = 23;
        spacing = 5;

        modules-left = [
          "custom/nix"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "battery"
        ];

        "custom/nix" = {
            format = "󱄅";
            tooltip = false;
            on-click = "powermenu";
        };

        clock = {
          format = "{:%I:%M %p - %B %d, %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          format = " {usage}%";
          on-click = "hyprctl dispatch exec '[float; size 1000 800; move center] ghostty -e btop'";
        };

        memory = {
          format = " {}%";
          on-click = "hyprctl dispatch exec '[float; size 1000 800; move center] ghostty -e btop'";
        };

        "hyprland/window" = {
          max-length = 30;
        };

        "hyprland/language" = {
          format-en = "En";
        };

        tray = {
          icon-size = 20;
          spacing = 8;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-bluetooth-muted = "󰸈";
          format-muted = "󰸈";
          format-icons = {
            headphone = "";
            hands-free = "󰂰";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "hyprctl dispatch exec '[float; size 600 700; move center] ghostty -e wiremix --tab output'";
        };

        bluetooth = {
          format = "";
          format-disabled = "";
          format-off = "";
          format-on = "󰂯";
          format-connected = "󰂱 {device_alias}";
          max-length = 16;
        };

        network = {
          format = "{ifname}";
          format-wifi = "{icon} {essid}";
          format-ethernet = "󰀂 {ipaddr}";
          format-disconnected = "󰤮 Disconnected";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 32;
          on-click = "rfkill unblock wifi && hyprctl dispatch exec '[float; size 900 700; move center] ghostty -e impala'";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-alt = "{icon} {time}";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "⼀";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
          };
          sort-by-number = true;
        };
      };
    };

    style = builtins.readFile ./style.css;
  };

  home.packages = with pkgs; [
    btop
    wiremix
    impala
  ];
}
