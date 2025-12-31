{ pkgs, lib, ... }: {
  boot = {
    kernelPackages = lib.mkForce pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    tmp.cleanOnBoot = true;

    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "vt.global_cursor_default=0"

      "amd_pstate=active"
      "nosplit_lock_mitigate"
      "clearcpuid=514"

      "preempt=full"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
