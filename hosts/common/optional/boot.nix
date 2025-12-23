{ pkgs, ... }: 
# TODO: make this better
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    tmp.cleanOnBoot = true;
    
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };
}
