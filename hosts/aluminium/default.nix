inputs@{
  nixpkgs,
  self,
  hm,
  nur,
  agenix,
  disko,
  ...
}:
let
  inherit (self) nixosModules;
  inherit (nixpkgs) lib;
  imports' = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
  keys = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./keys);
in
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self; };
  modules =
    with nixosModules;
    [
      core
      network
      nix
      grub_efi
      audio
      android
      bluetooth
      steam
      switch
      gamepads
      hm.nixosModules.home-manager
      nur.modules.nixos.default
      agenix.nixosModules.default
      disko.nixosModules.disko
      ./home.nix
      ../ssh.nix
      ../gpg.nix
    ]
    ++ imports'
    ++ keys;
}
