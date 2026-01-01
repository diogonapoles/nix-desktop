{ config, lib, pkgs, ... }:

{
  services.swayosd = {
    enable = true;
  };

  xdg.configFile = {
    "swayosd/config.toml".text = ''
      [server]
      show_percentage = true
      max_volume = 100
      style = "${config.xdg.configHome}/swayosd/style.css"
    '';

    "swayosd/style.css".text = ''
      @define-color background-color #${config.lib.stylix.colors.base00};
      @define-color border-color #${config.lib.stylix.colors.base04};
      @define-color label #${config.lib.stylix.colors.base05};
      @define-color image #${config.lib.stylix.colors.base05};
      @define-color progress #${config.lib.stylix.colors.base05};

      window {
        border-radius: 0;
        opacity: 0.97;
        border: 2px solid @border-color;
        background-color: @background-color;
      }

      label {
        font-family: 'JetBrainsMono Nerd Font';
        font-size: 11pt;
        color: @label;
      }

      image {
        color: @image;
      }

      progressbar {
        border-radius: 0;
      }

      progress {
        background-color: @progress;
      }
    '';
  };
}
