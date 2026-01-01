{ ... }:
{
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
    priority = 5;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 100;
    "vm.max_map_count" = 16777216;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "fs.file-max" = 2097152;
  };
}
