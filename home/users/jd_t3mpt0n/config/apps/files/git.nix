{ lib, ... }:
{
  programs.git = {
    extraConfig = {
      core = {
        editor = "emacsclient -c -a 'emacs'";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.config/git/allowed_signers";
      };
      signing = {
        key = "/home/jd/.ssh/gc.pub";
        signByDefault = true;
      };
      user = {
        signingkey = "/home/jd/.ssh/gc.pub";
      };
    };
  };
}
