{
  lib,
  pkgs,
  config,
  ...
}: {
  programs = {
    fzf.enable = lib.mkDefault true;
    zoxide.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    bat = {
      enable = lib.mkDefault true;
    };
  };
}
