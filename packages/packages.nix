pargs@{ pkgs, ... }:
let
  inherit (pkgs) lib;
  listFilesR = lib.filesystem.listFilesRecursive;
  lFR' = (dir: lib.filter (n: lib.hasSuffix ".nix" n) (listFilesR dir));
  imports' = lFR' ./music;
in
{
  imports = imports';
}
