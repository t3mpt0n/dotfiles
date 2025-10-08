{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  conf = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
in {
  imports = lib.lists.flatten [
    inputs.catppuccin.homeModules.catppuccin
    inputs.sops-nix.homeManagerModules.sops
    conf
    ./profile.nix
    ../../modules

    {
      programs = {
        vesktop.enable = true;
        fish.enable = true;
      };
    }
  ];
}
