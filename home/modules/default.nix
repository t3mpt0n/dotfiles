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
  browser_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./browsers);
  daemon_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./daemons);
  styling_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./styling);
  audio_mod = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./audio);
in {
  imports = lib.lists.flatten [
    crypt_mod
    window_mod
    shell_mod
    browser_mod
    daemon_mod
    styling_mod
    audio_mod
    ./editors/emacs/emacs.nix
  ];
}
