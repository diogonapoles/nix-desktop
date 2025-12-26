{ lib, pkgs, config, ... }:
let
  cfg = config.hardware.nvidia-custom;
in
{
  options.hardware.nvidia-custom = {
    enable = lib.mkEnableOption "NVIDIA GPU support with custom configuration";
  };

  config = lib.mkIf cfg.enable {
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

    # Extra kernel options
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

    # Suspend/resume support
    systemd.services.nvidia-suspend.enable = true;
    systemd.services.nvidia-resume.enable = true;
    systemd.services.nvidia-hibernate.enable = true;

    services.sunshine.settings = {
      max_bitrate = 20000; # in Kbps
      # NVIDIA NVENC Encoder
      nvenc_preset = 3; # 1(fastest + worst quality) - 7(slowest + best quality)
      nvenc_twopass = "full_res"; # quarter_res / full_res.
    };
  };
}
