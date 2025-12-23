{ pkgs, config, ... }: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/nixos/assets/forest-5.jpg";
          blur_size = 4;
          blur_passes = 2;
          noise = 0.02;
          contrast = 0.8916;
          brightness = 0.5172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      image = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/nixos/assets/profile/logonord.png";
          size = 300;
          position = "0, 10%";
          halign = "center";
          valign = "center";
          rounding = 300;
          border_size = 3;
          border_color = "rgba(235, 219, 178, 0.70)";
        }
      ];

      label = [
        {
          monitor = "";
          text = "welcome, ${config.home.username}";
          font_family = "JetBrainsMono Nerd Font";
          font_size = 25;
          halign = "center";
          valign = "center";
          position = "0, 0%";
          color = "rgba(235, 219, 178, 0.90)"; 
        }
        {
          monitor = "";
          text = ''cmd[update:1000] date +"%H:%M"'';
          font_family = "JetBrainsMono Nerd Font";
          font_size = 100;
          halign = "center";
          valign = "center";
          position = "0, 35%";
          color = "rgba(235, 219, 178, 0.85)";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
          font_family = "JetBrainsMono Nerd Font";
          font_size = 25;
          halign = "center";
          valign = "center";
          position = "0, 30%";
          color = "rgba(235, 219, 178, 0.85)";
        }
      ];

      "input-field" = [
        {
          monitor = "";
          size = "550, 90";
          position = "0, -5%";
          halign = "center";
          valign = "center";

          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(50, 48, 47, 0.6)"; 
          outline_thickness = 3;

          dots_size = 0.2;
          dots_spacing = 0.3;

          font_family = "Iosevka Nerd Font";
          font_color = "rgb(235, 219, 178)"; 

          placeholder_text = "Enter Password";
          check_color = "rgb(250, 189, 47)"; 
          fail_color = "rgb(251, 73, 52)"; 
          fail_text = " Invalid Password";

          rounding = 96;
          shadow_passes = 0;
          fade_on_empty = false;
        }
      ];

      auth = {
        fingerprint = {
          enabled = true;
        };
      };
    };
  };
}
