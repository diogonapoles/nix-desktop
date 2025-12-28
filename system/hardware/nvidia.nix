{ pkgs, config, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    # Since NVIDIA does not load kernel mode setting by default,
    # enabling it is required to make Wayland compositors function properly.
    "nvidia-drm.fbdev=1"
  ];

  hardware.nvidia-container-toolkit.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;

    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    prime.offload.enable = false;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.variables = {
    __GL_SHADER_DISK_CACHE_SIZE = "12000000000";
  };

  boot.blacklistedKernelModules = ["nouveau" "nova_core"];

  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
    options nvidia NVreg_DriverObjectModel=1
    options nvidia NVreg_UsePageAttributeTable=1
    options nvidia NVreg_EnableResizableBar=1
    options nvidia NVreg_EnableGpuFirmware=1
    options nvidia NVreg_DynamicPowerManagement=0x02
    options nvidia NVreg_EnableStreamMemOPs=1
    options nvidia NVreg_RegistryDwords="RmEnableAggressiveVblank=1;RMIntrLockingMode=1"
  '';

  systemd.services.nvidia-suspend.enable = true;
  systemd.services.nvidia-resume.enable = true;
  systemd.services.nvidia-hibernate.enable = true;

  services.sunshine.settings = {
    upnp = true;
    output_name = "1";

    # NVENC encoder settings optimized for Steam Deck OLED low-latency streaming
    encoder = "nvenc";

    # P1 preset = lowest encoding latency (~458 fps encoding speed)
    nvenc_preset = 1;

    # Ultra Low Latency tuning = strict in-order pipeline, no B-frames
    # This is the key setting for minimizing latency
    nvenc_tuning = "ull";

    # Constant bitrate for consistent frame pacing
    nvenc_rc = "cbr";

    # Quarter-res two-pass helps bitrate distribution
    nvenc_twopass = "quarter_res";

    # 20 Mbps for Steam Deck OLED (increased from 15 Mbps)
    # OLED can handle better quality while maintaining low latency
    bitrate = 20000;

    # Minimize threading overhead
    min_threads = 1;
  };
}
