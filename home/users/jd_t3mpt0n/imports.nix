{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  conf = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
  mod_apps = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/apps);
  mod_shell = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/shell);
  mod_wm = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/wm);
in
{
  imports =
    mods
    ++ conf
    ++ [
      ../../modules/fonts
      ../../modules/editors/emacs/emacs.nix
      ./profile.nix
    ];
}
