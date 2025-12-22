{ 
  config, 
  ... 
}: {
  programs.git = {
    enable = true;

    lfs.enable = true;

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "diogonapoles";
        email = "napolesdr@gmail.com";
      };

      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;

      core.editor = "nvim";
      fetch.prune = true;
      rebase.autoStash = true;

      url."ssh://git@github.com/".insteadOf = "https://github.com/";

      # TODO: add alias later
      # alias = {
      # };
    };
  };
}
