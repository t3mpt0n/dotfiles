{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.rbw = {
    settings = {
      email = "mail@t3mpt0n.com";
      lock_timeout = 300;
      pinentry = pkgs.pinentry-emacs;
    };
  };
}
