{
  lib,
  config,
  pkgs,
  ...
}:
let
  crypt_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./crypt);
  window_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./wm);
  shell_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./shell);
in {
  imports = lib.lists.flatten [
    crypt_mod
    window_mod
    shell_mod
  ];
}
