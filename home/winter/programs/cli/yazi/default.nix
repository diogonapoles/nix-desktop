{ 
  pkgs, 
  ... 
}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;

    plugins = {
      starship = pkgs.fetchFromGitHub {
        owner = "Rolv-Apneseth";
        repo = "starship.yazi";
        rev = "a63550b";
        sha256 = "sha256-PYeR6fiWDbUMpJbTFSkM57FzmCbsB4W4IXXe25wLncg=";
      };
    };

    initLua = ''
      require("starship"):setup()
    '';

    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
      preview = {
        image_delay = 10;
      };
      opener = {
        edit = [
          {
            run = ''nvim "$@"'';
            block = true;
            desc = "nvim";
            for = "unix";
          }
        ];
        zathura = [
          {
            run = ''zathura "$@"'';
            orphan = true;
            desc = "zathura";
            for = "unix";
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "text/*";
            use = ["edit"];
          }
          {
            mime = "application/pdf";
            use = ["zathura"];
          }
        ];
      };
    };
  };
}
