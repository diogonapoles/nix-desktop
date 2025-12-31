{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    protonup-qt      # Compatibility tool installer
    mesa-demos       # Show hardware information
    heroic           # Native GOG, Epic, and Amazon Games Launcher for Linux, Windows and Mac
    joystickwake     # Joystick-aware screen waker
    mangohud         # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
    umu-launcher     # Unified launcher for Windows games on Linux using the Steam Linux Runtime and Tools
    winetricks       # Script to install DLLs needed to work around problems in Wine
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    MANGOHUD_CONFIG = "control=mangohud,legacy_layout=0,vertical,background_alpha=0,gpu_stats,gpu_power,gpu_temp,cpu_stats,cpu_temp,core_load,ram,vram,fps,fps_metrics=AVG,0.001,frametime,refresh_rate,resolution, vulkan_driver,wine";

    __GL_GSYNC_ALLOWED = "1";
    __GL_VRR_ALLOWED = "1";
    PROTON_ENABLE_NVAPI = "1";
    PROTON_HIDE_NVIDIA_GPU = "0";
    PROTON_ENABLE_NGX_UPDATER = "1";
  };

  services.udev.extraRules = ''
    # USB
    ATTRS{name}=="Sony Interactive Entertainment Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    # Bluetooth
    ATTRS{name}=="Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
    ATTRS{name}=="DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  hardware.steam-hardware.enable = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        disable_splitlock = 1;
        inhibit_screensaver = 1;
        ioprio = 0;
        renice = 10;
        softrealtime = "auto";
      };
      cpu = {
        park_cores = "yes";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        nv_powermizer_mode = "1";
        gpu_device = "2"; 
      };
    };
  };

  # Gamescope configuration
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;

    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          # controller support libraries
          libusb1
          udev
          SDL2

          # additional libraries for better compatibility
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXrender
          xorg.libXext

          # fix for Xwayland symbol errors
          libkrb5
          keyutils
        ];
    };

    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
