{ lib, config, pkgs, ... }:
let
  cfg = config.gaming.steam-custom;
in
{
  options.gaming.steam-custom = {
    enable = lib.mkEnableOption "Gaming support with Steam and related tools";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mesa-demos       # Show hardware information
      heroic           # Native GOG, Epic, and Amazon Games Launcher for Linux, Windows and Mac
      joystickwake     # Joystick-aware screen waker
      mangohud         # Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
      oversteer        # Steering Wheel Manager for Linux
      umu-launcher     # Unified launcher for Windows games on Linux using the Steam Linux Runtime and Tools
      winetricks       # Script to install DLLs needed to work around problems in Wine

      # Performance monitoring tools
      htop             # CPU monitoring
      iotop            # I/O monitoring

      # Gaming status helper script
      (pkgs.writeShellScriptBin "gaming-status" ''
        #!/usr/bin/env bash
        echo "========================================="
        echo "  Gaming System Status Check"
        echo "========================================="
        echo ""

        echo "=== CPU Information ==="
        echo "CPU Governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
        echo "CPU EPP: $(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference 2>/dev/null || echo 'N/A')"
        echo "CPU Frequency: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | awk '{print $1/1000000 " GHz"}')"
        echo ""

        echo "=== GPU Information ==="
        nvidia-smi --query-gpu=name,driver_version,memory.total,clocks.max.graphics,clocks.current.graphics,power.draw --format=csv,noheader
        echo ""

        echo "=== Resizable BAR Status ==="
        nvidia-smi -q | grep -A 3 "BAR1"
        echo ""

        echo "=== Memory Configuration ==="
        sysctl vm.swappiness vm.dirty_ratio vm.max_map_count
        echo ""

        echo "=== ZRAM Status ==="
        zramctl 2>/dev/null || echo "ZRAM not enabled"
        echo ""

        echo "=== Kernel Parameters ==="
        cat /proc/cmdline | tr ' ' '\n' | grep -E 'preempt|thread|nohz|amd_pstate|rcu'
        echo ""

        echo "=== GameMode Status ==="
        gamemoded -t 2>/dev/null || echo "GameMode not running"
        echo ""

        echo "=== NVIDIA Driver Parameters ==="
        cat /proc/driver/nvidia/params 2>/dev/null | grep -E 'UsePageAttributeTable|EnableResizableBar|EnableGpuFirmware' || echo "Cannot read NVIDIA params"
        echo ""

        echo "========================================="
        echo "  Status check complete!"
        echo "========================================="
      '')
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

    # Hardware support
    hardware.steam-hardware.enable = true;
    hardware.xone.enable = true;
    hardware.xpadneo.enable = true;
    hardware.opentabletdriver.enable = true;

    programs.gamemode = {
      enable = true;
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
            # Controller support libraries
            libusb1
            udev
            SDL2

            # Additional libraries for better compatibility
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            xorg.libXcomposite
            xorg.libXdamage
            xorg.libXrender
            xorg.libXext

            # Fix for Xwayland symbol errors
            libkrb5
            keyutils
          ];
      };

      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
