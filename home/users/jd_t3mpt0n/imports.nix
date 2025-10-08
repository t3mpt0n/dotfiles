{
  inputs,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  conf = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
in
{
  imports = lib.lists.flatten [
    inputs.sops-nix.homeManagerModules.sops
    inputs.catppuccin.homeModules.catppuccin
    inputs.plasma-manager.homeModules.plasma-manager
    conf
    ../../modules
    ./profile.nix

    {
      programs = {
        vesktop.enable = true;
        fish.enable = true;
      };
    }
  ];
}
