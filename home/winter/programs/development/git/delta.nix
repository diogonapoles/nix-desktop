{ ... }: {
  programs.delta = {
    enable = true;
    options = {
      diff-so-fancy = true;
      line-numbers = true;
      true-color = "always";
      navigate = true;
      side-by-side = false;
    };
  };
}
