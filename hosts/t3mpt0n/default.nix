inputs@{
  nixpkgs,
  self,
  hm,
  nur,
  agenix,
  nixpkgs-stable,
  devenv,
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
  specialArgs = { inherit inputs self t3mpt0n_nvim nixpkgs-stable; };
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
      printer
      gamingmice
      hm.nixosModules.home-manager
      nur.modules.nixos.default
      agenix.nixosModules.default
      ./home.nix
      ../ssh.nix
      ../gpg.nix
      {
        environment.systemPackages = [ devenv.packages.x86_64-linux.devenv ];
      }
    ]
    ++ imports'
    ++ keys;
}
