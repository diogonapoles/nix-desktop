{ pkgs, ... }: {
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";

      # aliases = {
      #   co = "pr checkout";
      #   pv = "pr view";
      # };
    };
  };

  # TODO: add extensions later
  # home.packages = with pkgs; [
  #   gh-markdown-preview
  # ];
}
