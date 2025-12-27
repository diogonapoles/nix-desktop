{
  config,
  pkgs,
  ...
}: {
  # Git configuration
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
    };
  };

  # Delta (diff viewer)
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

  # GitHub CLI
  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  # Lazygit
  programs.lazygit.enable = true;

  # SSH configuration
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
        user = "git";
      };
    };
  };

  services.ssh-agent.enable = true;
}
