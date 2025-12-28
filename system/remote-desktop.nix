{
  pkgs,
  config,
  ...
}:
let
  homeDir = config.users.users.winter.home;
in
{
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
    capSysAdmin = true; # omit this when using with Xorg
    openFirewall = true;

    # override package to add CUDA support and NVIDIA runtime dependencies
    package = pkgs.sunshine.override {
      cudaSupport = true;
    };
  };

  # GPU library paths to systemd service environment for NVENC support
  systemd.user.services.sunshine = {
    serviceConfig.Environment = [
      "LD_LIBRARY_PATH=/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    ];
  };
}
