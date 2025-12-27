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
          color = "rgba(40, 40, 40, 1.0)";
          path = "${config.home.homeDirectory}/nixos/assets/forest-5.jpg";
          blur_passes = 3;
        }
      ];

      animations = {
        enabled = false;
      };
      
      "input-field" = [
        {
          monitor = "";
          size = "650, 100";
          position = "0, 0";
          halign = "center";
          valign = "center";
          inner_color = "rgba(40, 40, 40, 0.8)";
          outer_color = "rgba(212, 190, 152, 1.0)";
          outline_thickness = 4;
          font_family = "JetBrainsMono Nerd Font";
          font_color = "rgba(212, 190, 152, 1.0)";
          dots_size = 0.2;
          dots_spacing = 0.3;
          placeholder_text = "Enter Password";
          check_color = "rgba(214, 153, 92, 1.0)";
          fail_text = "<i>$FAIL ($ATTEMPTS)</i>";
          rounding = 0;
          shadow_passes = 0;
          fade_on_empty = false;
        }
      ];
    };
  };
}
