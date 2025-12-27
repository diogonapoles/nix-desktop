{
  config,
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
          "image"
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

        image = {
          path = ./nix.svg;
          size = 20;
          interval = 5;
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

    style = ''
      /* -----------------------------------------------------------------------------
       * Base styles with Stylix colors
       * -------------------------------------------------------------------------- */

      * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base06};
        transition-property: background-color;
        transition-duration: 0.5s;
        margin: 2px 5px 0 5px;
        margin-bottom: 8px;
      }

      #image {
        margin-left: 5px;
      }

      #battery,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray,
      #language,
      #bluetooth,
      #mic,
      #sound {
        padding: 1px 10px;
        background-color: transparent;
      }

      #clock {
        color: #${config.lib.stylix.colors.base00};
        background-color: #${config.lib.stylix.colors.base0D};
      }

      #pulseaudio {
        background-color: #${config.lib.stylix.colors.base01};
      }

      #network {
        background-color: #${config.lib.stylix.colors.base01};
      }

      #cpu {
        background-color: #${config.lib.stylix.colors.base01};
      }

      #memory {
        background-color: #${config.lib.stylix.colors.base01};
      }

      @keyframes blink {
        to {
          border-color: #${config.lib.stylix.colors.base0D};
        }
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #${config.lib.stylix.colors.base06};
        font-family: "Noto Sans JP", "JetBrainsMono Nerd Font";
      }

      #workspaces button:hover {
        background: #${config.lib.stylix.colors.base01};
      }

      #workspaces button.active {
        color: #${config.lib.stylix.colors.base00};
        background-color: #${config.lib.stylix.colors.base0B};
      }

      #workspaces button.urgent {
        background-color: #${config.lib.stylix.colors.base08};
      }
    '';
  };

  home.packages = with pkgs; [
    btop
    wiremix
    impala
  ];
}
