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
      capSysAdmin = true; # only needed for Wayland
      openFirewall = true;
      settings = {
        # pc  - Only localhost may access the web ui
        # lan - Only LAN devices may access the web ui
        origin_web_ui_allowed = "pc";
        lan_encryption_mode = 2;
        wan_encryption_mode = 2;
      };
    };
  };
}
