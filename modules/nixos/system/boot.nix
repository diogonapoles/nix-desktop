{ lib, config, pkgs, ... }:
let
  cfg = config.system.boot-custom;
in
{
  options.system.boot-custom = {
    enable = lib.mkEnableOption "Custom boot configuration with Zen kernel";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_zen;

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
  };
}
