inputs@{
  nixpkgs,
  self,
  agenix,
  hm,
  nur,
  disko,
  ...
}:
let
  inherit (self) nixosModules;
  inherit (nixpkgs) lib;
  imports' = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
  deploy = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./deploy);
  agekeys = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./keys);
in
lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self; };
  modules =
    with nixosModules;
    [
      core
      network
      nix
      audio
      bluetooth
      grub_efi
      agenix.nixosModules.default
      hm.nixosModules.home-manager
      nur.modules.nixos.default
      disko.nixosModules.disko
    ]
    ++ imports'
    ++ deploy
    ++ agekeys;
}
