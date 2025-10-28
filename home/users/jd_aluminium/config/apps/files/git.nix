{ lib, config, ... }:
{
  programs.git = {
    extraConfig = {
      core = {
        editor = "nvim";
        sshCommand = "ssh -i ~/.ssh/ga";
      };
      gpg = {
        format = if config.programs.gpg.enable then "openpgp" else "ssh";
        ssh.allowedSignersFile = lib.mkIf (config.programs.gpg.enable != true) "~/.config/git/allowed_signers";
      };
      signing = {
        key = if config.programs.gpg.enable then "A3E735D6C0921B17" else "/home/jd/.ssh/gc.pub";
        signByDefault = true;
      };
      user = {
        signingkey = config.programs.git.extraConfig.signing.key;
      };
    };
  };
}
