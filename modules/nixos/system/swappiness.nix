{ lib, config, ... }:
let
  cfg = config.system.swappiness-custom;
in
{
  options.system.swappiness-custom = {
    enable = lib.mkEnableOption "Custom memory and swap configuration";
  };

  config = lib.mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";           
      memoryPercent = 25;            
      priority = 5;                
    };

    boot.kernel.sysctl = {
      # ZRAM-optimized swappiness
      "vm.swappiness" = 10;

      # Cache pressure (how aggressively kernel reclaims cache)
      "vm.vfs_cache_pressure" = 50;

      "vm.dirty_bytes" = 268435456;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;

      # Keep existing max_map_count for gaming
      "vm.max_map_count" = 16777216;
    };
  };
}
