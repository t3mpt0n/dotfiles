{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = lib.mkDefault true;
    userName = "t3mpt0n";
    userEmail = "mail@t3mpt0n.com";
    settings = {
      safe.directory = "/etc/nixos";
      init.defaultBranch = "main";
      commit.gpgSign = true;
      user.signingkey = "A3E735D6C0921B17";
      gpg.program = "${pkgs.gnupg}";
      core = {
        autocrlf = "input";
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
      
    };
  };
}
