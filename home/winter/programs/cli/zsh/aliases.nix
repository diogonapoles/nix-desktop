{
  ...
}: {
  programs.zsh = {
    shellAliases = {
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      cd = "z";
      vim = "nvim";
      grep = "grep --color=auto";
      c = "clear";
    };
  };
}
