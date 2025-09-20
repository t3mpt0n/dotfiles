{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  conf = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
  mods = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ../../modules);
in
{
  imports =
    mods
    ++ conf
    ++ [
      inputs.nixvim.homeManagerModules.nixvim
      ./profile.nix
    ];
}
