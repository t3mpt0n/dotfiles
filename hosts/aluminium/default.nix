inputs@{
  nixpkgs,
  self,
  hm,
  nur,
  devenv,
  disko,
  ...
}:
let
  inherit (self) nixosModules;
  inherit (nixpkgs) lib;
  imports' = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
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
      disko.nixosModules.disko
      ./home.nix
      ../crypt.nix
      {
        environment.systemPackages = [ devenv.packages.x86_64-linux.devenv ];
      }
    ]
    ++ imports';
}
