{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./aria2.nix
  ];
}
