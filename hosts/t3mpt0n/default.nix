inputs@{
  nixpkgs,
    self,
    hm,
    nur,
    agenix,
    nixpkgs-stable,
    devenv,
    disko,
    catppuccin,
    ...
}:
let
  inherit (self) nixosModules;
  inherit (nixpkgs) lib;
  imports' = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
in
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self nixpkgs-stable; };
  modules =
    with nixosModules;
    [
      core
      network
      nix
      audio
      android
      bluetooth
      steam
      switch
      gamepads
      printer
      gamingmice
      systemdboot
      agenix.nixosModules.default
      ./age.nix
      {
        environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
      }
      
      hm.nixosModules.home-manager
      nur.modules.nixos.default
      disko.nixosModules.disko
      catppuccin.nixosModules.catppuccin
      ./home.nix
      ../crypt.nix
      ./install.nix
      {
        environment.systemPackages = [ devenv.packages.x86_64-linux.devenv ];
      }
    ]
    ++ imports';
}
