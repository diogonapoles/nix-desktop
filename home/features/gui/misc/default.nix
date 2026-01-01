{ pkgs, ... }: {
  home.packages = with pkgs; [
    impala
    claude-code
    wpa_supplicant_gui
  ];
}
