{
  config,
  ...
}: {
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    prime.offload.enable = false;
  };

  # shader cache
  environment.variables = {
    __GL_SHADER_DISK_CACHE_SIZE = "12000000000";
  };

  boot.blacklistedKernelModules = [ "nouveau" ];

  # extra kernel options
  boot.extraModprobeConfig = ''
    options nvidia NVreg_PreserveVideoMemoryAllocations=1
    options nvidia NVreg_TemporaryFilePath=/var/tmp
    options nvidia NVreg_UsePageAttributeTable=1
  '';

  # suspend/resume support
  systemd.services.nvidia-suspend.enable = true;
  systemd.services.nvidia-resume.enable = true;
  systemd.services.nvidia-hibernate.enable = true;
}
