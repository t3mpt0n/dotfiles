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
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    conf
    ../../modules
    ./profile.nix

    {
      programs = {
        vesktop.enable = true;
        fish.enable = true;
      };

      t'.home.crypto.enable = true;
      
      services.flatpak = {
        enable = true;
        packages = [
          "net.retrodeck.retrodeck"
        ];
      };
    }
  ];
}
