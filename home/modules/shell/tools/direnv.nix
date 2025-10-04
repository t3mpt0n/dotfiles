{
  lib,
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = lib.mkDefault true;
    nix-direnv.enable = lib.mkDefault true;
  };
}
