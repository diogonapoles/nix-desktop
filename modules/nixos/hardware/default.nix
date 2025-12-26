{
  imports = [
    ./nvidia.nix
    ./bluetooth.nix
  ];

  powerManagement.cpuFreqGovernor = "performance";
}
