{ lib, config, ... }:
let
  cfg = config.programs.toolkit-env;
in
{
  options.programs.toolkit-env = {
    enable = lib.mkEnableOption "Toolkit environment variables (Qt, GTK, SDL, Java)";

    gdkScale = lib.mkOption {
      type = lib.types.int;
      default = 2;
      description = "GTK HiDPI scaling factor";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      # Qt Configuration

      # Qt window decorations
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Qt platform plugin
      QT_QPA_PLATFORM = "wayland";

      # SDL Configuration

      # SDL video driver
      SDL_VIDEODRIVER = "wayland";

      # GTK Configuration

      # GTK backend selection
      # Prefer Wayland but fallback to X11 if needed
      GDK_BACKEND = "wayland, x11";

      # GTK HiDPI scaling factor
      GDK_SCALE = toString cfg.gdkScale;

      # Application-Specific Compatibility

      # Java AWT window manager compatibility
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };
}
