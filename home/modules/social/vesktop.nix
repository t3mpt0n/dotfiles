{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.vesktop = {
    enable = lib.mkDefault false;
  };
}
