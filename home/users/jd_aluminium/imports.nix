{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  conf = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
  mod_apps = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/apps);
  mod_wm = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/wm);
  mod_shell = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules/shell);
in {
  imports =
    mod_apps
    ++ mod_wm
    ++ mod_shell
    ++ conf
    ++ [
      inputs.catppuccin.homeModules.catppuccin
      inputs.agenix.homeManagerModules.default
      ./profile.nix
      ../../modules/mail.nix
      ../../modules/age.nix
      ../../modules/fonts.nix
      ../../modules/catppuccin.nix
      ../../modules/editors/emacs/emacs.nix
    ];
}
