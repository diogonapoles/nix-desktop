{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.system.remote-desktop-custom;
in {
  options.system.remote-desktop-custom = {
    enable = lib.mkEnableOption "Remote Desktop (Sunshine and Moonlight) support with custom configuration";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      moonlight-qt
    ];

    # ===============================================================================
    #
    # How to use:
    #  1. setup user via Web Console: <https://localhost:47990/>):
    #  2. on another machine, connect to sunshine via moonlight-qt client
    #
    # systemctl --user status sunshine
    #
    # ===============================================================================
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
      openFirewall = true;

      # Override package to add CUDA support and NVIDIA runtime dependencies
      package = pkgs.sunshine.override {
        cudaSupport = true;
      };
    };

    # Add GPU library paths to systemd service environment for NVENC support
    systemd.user.services.sunshine = {
      serviceConfig.Environment = [
        "LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib"
      ];
    };
  };
}
