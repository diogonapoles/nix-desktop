{
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
in
{
  imports = [
    ../../home/core.nix
    ../../home/wayland.nix
    ../../home/git.nix
    ../../home/stylix.nix
    ../../home/fonts.nix
    ../../home/gtk.nix
    ../../home/scripts.nix

    # shell
    ../../home/shell/zsh

    # terminal programs
    ../../home/terminal/ghostty
    ../../home/terminal/yazi
    ../../home/terminal/btop
    ../../home/terminal/fastfetch

    # wm and companions
    ../../home/wm/hyprland
    ../../home/wm/waybar
    ../../home/wm/hyprlock
    ../../home/wm/rofi
    ../../home/wm/swayidle
    ../../home/wm/swayosd
    ../../home/wm/mako

    # gui apps
    ../../home/apps/firefox
    ../../home/apps/discord
    ../../home/apps/obsidian
    ../../home/apps/zathura
    ../../home/apps/misc.nix
  ];

  programs.wayland = {
    enable = true;
    nvidia.enable = true;
    toolkit.gdkScale = 2;
  };

  wayland.windowManager.hyprland.settings.monitor =
    "DP-3, highres@highrr, auto, 1.5, bitdepth,10";

  # Declarative Sunshine apps.json configuration for Steam Deck streaming
  xdg.configFile."sunshine/apps.json" = {
    text = builtins.toJSON {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
        {
          name = "Steam Big Picture";
          output = 1;
          prep-cmd = [
            {
              do = "sunshine-monitor-create && sleep 1";
              undo = "sunshine-monitor-remove && setsid steam steam://close/bigpicture";
            }
          ];
          cmd = "sunshine-launch-steam";
          image-path = "steam.png";
        }
      ];
    };
    onChange = ''
      # Restart Sunshine when apps.json changes
      systemctl --user restart sunshine.service 2>/dev/null || true
    '';
  };

  home.sessionVariables.NH_FLAKE = "${homeDir}/nixos";
}
