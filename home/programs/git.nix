{
  config,
  inputs,
  osConfig,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userName = "t3mpt0n";
      userEmail = "git@t3mpt0n.com";

      signing = {
        key = "/home/jd/.ssh/t3mpt0n_sign-git.pub";
        signByDefault = true;
      };

      extraConfig = {
        core = {
          editor = "emacsclient -c -a 'emacs'";
          autocrlf = "input";
        };
        init = {
          defaultBranch = "main";
        };

        color = {
          ui = "auto";
          "status" = {
            branch = "magenta";
            untracked = "cyan";
            unmerged = "yellow";
            header = "bold white";
          };
        };
        commit.gpgSign = false;
        gpg = {
          format = "ssh";
        };
      };
    };
  };
}
