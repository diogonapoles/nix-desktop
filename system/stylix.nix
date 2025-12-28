{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.stylix-custom;
in {
  options.stylix-custom = {
    enable = lib.mkEnableOption "stylix theming system";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      description = "Path to base16 color scheme yaml file";
    };

    polarity = lib.mkOption {
      type = lib.types.enum ["dark" "light"];
      default = "dark";
      description = "Color scheme polarity (dark or light)";
    };

    cursor = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Cursor theme name";
      };

      package = lib.mkOption {
        type = lib.types.package;
        description = "Cursor theme package";
      };

      size = lib.mkOption {
        type = lib.types.int;
        default = 24;
        description = "Cursor size";
      };
    };

    icons = {
      package = lib.mkOption {
        type = lib.types.package;
        description = "Icon theme package";
      };

      dark = lib.mkOption {
        type = lib.types.str;
        description = "Dark icon theme name";
      };

      light = lib.mkOption {
        type = lib.types.str;
        description = "Light icon theme name";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = cfg.colorscheme;
      polarity = cfg.polarity;

      cursor = {
        inherit (cfg.cursor) name package size;
      };

      icons = {
        enable = true;
        package = cfg.icons.package;
        dark = cfg.icons.dark;
        light = cfg.icons.light;
      };

      homeManagerIntegration = {
        autoImport = true;
        followSystem = true;
      };
    };
  };
}
