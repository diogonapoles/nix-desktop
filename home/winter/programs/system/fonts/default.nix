{
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    nerd-fonts.caskaydia-cove
    nerd-fonts.symbols-only
    nerd-fonts.iosevka 
    twemoji-color-font
    noto-fonts-color-emoji
    fantasque-sans-mono
    font-awesome
  ];
}
