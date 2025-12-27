{
  config,
  pkgs,
  ...
}: let
  stylixTheme = pkgs.writeText "stylix-rofi-theme.rasi" ''
    * {
        /* Colors */
        bg0:          #${config.lib.stylix.colors.base00};
        bg1:          #${config.lib.stylix.colors.base01};        
        bg3:          #${config.lib.stylix.colors.base03};
        fg0:          #${config.lib.stylix.colors.base07};
        fg1:          #${config.lib.stylix.colors.base06};
        red:          #${config.lib.stylix.colors.base08};
        yellow:       #${config.lib.stylix.colors.base0A};
        gray:         #${config.lib.stylix.colors.base04};

        /* Applied colors */
        background:                  @bg0;
        background-color:            @background;
        foreground:                  @fg1;
        border-color:                @gray;

        normal-background:           @background;
        normal-foreground:           @foreground;
        alternate-normal-background: @bg1;
        alternate-normal-foreground: @foreground;
        selected-normal-background:  @bg3;
        selected-normal-foreground:  @fg0;

        active-background:           @yellow;
        active-foreground:           @background;
        alternate-active-background: @active-background;
        alternate-active-foreground: @active-foreground;
        selected-active-background:  @yellow;
        selected-active-foreground:  @active-foreground;

        urgent-background:           @red;
        urgent-foreground:           @background;
        alternate-urgent-background: @urgent-background;
        alternate-urgent-foreground: @urgent-foreground;
        selected-urgent-background:  @red;
        selected-urgent-foreground:  @urgent-foreground;
    }
    
    window {
        padding: 1;
        border: 2;
        border-color: var(border-color);
        background-color: var(background-color);
        width: 30%;
        height: 250;
    }
    
    mainbox {
        padding: 0;
        border: 0;
    }
    
    inputbar {
        padding: 4px;
        margin: 6px;
        text-color: var(normal-foreground);
        background-color: var(alternate-normal-background);
        children: [ entry ];
    }
    
    entry {
        text-color: var(normal-foreground);
        background-color: var(background);
    }
    
    listview {
        margin: 0px 0px 5px;
        spacing: 5px;
    }
    
    element {
        padding: 1px;
        spacing: 2px;
        border: 0;
    }
    
    element normal.normal {
        background-color: var(normal-background);
        text-color: var(normal-foreground);
    }
    
    element normal.urgent {
        background-color: var(urgent-background);
        text-color: var(urgent-foreground);
    }
    
    element normal.active {
        background-color: var(active-background);
        text-color: var(active-foreground);
    }
    
    element selected.normal {
        background-color: var(selected-normal-background);
        text-color: var(selected-normal-foreground);
    }
    
    element selected.urgent {
        background-color: var(selected-urgent-background);
        text-color: var(selected-urgent-foreground);
    }
    
    element selected.active {
        background-color: var(selected-active-background);
        text-color: var(selected-active-foreground);
    }
    
    element alternate.normal {
        background-color: var(alternate-normal-background);
        text-color: var(alternate-normal-foreground);
    }
    
    element alternate.urgent {
        background-color: var(alternate-urgent-background);
        text-color: var(alternate-urgent-foreground);
    }
    
    element alternate.active {
        background-color: var(alternate-active-background);
        text-color: var(alternate-active-foreground);
    }
    
    element-text {
        background-color: rgba(0, 0, 0, 0%);
        text-color: inherit;
    }
    
    element-icon {
        background-color: rgba(0, 0, 0, 0%);
        size: 1.0000em;
        text-color: inherit;
    }
  '';

  powermenuTheme = pkgs.writeText "stylix-powermenu-theme.rasi" ''
    * {
        bg-col: #${config.lib.stylix.colors.base00};
        bg-col-light: #${config.lib.stylix.colors.base00};
        border-col: #${config.lib.stylix.colors.base04};
        selected-col: #${config.lib.stylix.colors.base01};
        green: #${config.lib.stylix.colors.base0B};
        fg-col: #${config.lib.stylix.colors.base07};
        fg-col2: #${config.lib.stylix.colors.base06};
        grey: #${config.lib.stylix.colors.base04};
        highlight: @green;
    }
  '';
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font regular 13";
    theme = "${stylixTheme}";

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "Applications";
      display-run = "Run";
      display-window = "Windows";
    };
  };

  xdg.configFile."rofi/powermenu/theme.rasi".source = powermenuTheme;
  xdg.configFile."rofi/powermenu/powermenu.rasi".source = ./powermenu/powermenu.rasi;
}
