{
  config,
  ...
}: {
  boot.initrd.kernelModules = ["nvidia"];

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

  services.xserver.videoDrivers = [ "nvidia" ];
}
