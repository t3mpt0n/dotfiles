{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "t3mpt0n";
    userEmail = "git@t3mpt0n.com";
    extraConfig = {
      safe.directory = "/etc/nixos";
      core = {
        autocrlf = "input";
      };
      init.defaultBranch = "main";
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
    };
  };
}
