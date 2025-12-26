{ lib, config, ... }:
let
  cfg = config.hardware.nvidia-env;
in
{
  options.hardware.nvidia-env = {
    enable = lib.mkEnableOption "NVIDIA environment variables for Wayland";

    backend = lib.mkOption {
      type = lib.types.enum [ "direct" "auto" ];
      default = "direct";
      description = "NVIDIA Direct rendering backend type";
    };
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables = {
      # Hardware video acceleration
      LIBVA_DRIVER_NAME = "nvidia";

      # OpenGL vendor
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # NVIDIA Direct rendering backend
      NVD_BACKEND = cfg.backend;

      # Generic Buffer Management backend
      GBM_BACKEND = "nvidia-drm";

      # Disable atomic mode setting for wlroots
      # Workaround for NVIDIA compatibility with wlroots-based compositors
      WLR_DRM_NO_ATOMIC = 1;
    };
  };
}
