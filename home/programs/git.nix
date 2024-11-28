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
        key = "/home/jd/.ssh/gc.pub";
        signByDefault = true;
      };

      extraConfig = {
        safe.directory = "/etc/nixos";
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
        commit.gpgSign = true;
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };
    };
  };

  home.file.".config/git/allowed_signers" = {
    text = config.programs.git.userEmail + " ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbg9v5g+gFpjAUr0CjEuHIeqV/CUmCe9QXWzIHkBnQi";
  };
}
