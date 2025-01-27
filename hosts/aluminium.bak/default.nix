inputs@{
  nixpkgs,
  self,
  agenix,
  hm,
  nur,
  disko,
  t3mpt0n_nvim,
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
  specialArgs = { inherit nixpkgs self; };
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
      ../ssh.nix
      ./home.nix
      {
        environment.systemPackages = [
          t3mpt0n_nvim.outputs.packages.x86_64-linux.default
        ];
      }
    ]
    ++ imports'
    ++ deploy
    ++ agekeys;
}
