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
          color = "rgb(${config.lib.stylix.colors.base00})";
          path = "${config.home.homeDirectory}/nixos/assets/1377788.png";
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
          inner_color = "rgba(${config.lib.stylix.colors.base00-rgb-r}, ${config.lib.stylix.colors.base00-rgb-g}, ${config.lib.stylix.colors.base00-rgb-b}, 0.8)";
          outer_color = "rgb(${config.lib.stylix.colors.base05})";
          outline_thickness = 4;
          font_family = "JetBrainsMono Nerd Font";
          font_color = "rgb(${config.lib.stylix.colors.base05})";
          dots_size = 0.2;
          dots_spacing = 0.3;
          placeholder_text = "Enter Password";
          check_color = "rgb(${config.lib.stylix.colors.base09})";
          fail_text = "<i>$FAIL ($ATTEMPTS)</i>";
          rounding = 0;
          shadow_passes = 0;
          fade_on_empty = false;
        }
      ];
    };
  };
}
