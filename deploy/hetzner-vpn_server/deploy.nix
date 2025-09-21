inputs@{
  nixpkgs-stable,
  self,
  ...
}:
let
  inherit (self) nixosModules;
in nixpkgs-stable.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self; };
  modules = with nixosModules; [
    core
    nix
    network
    systemdboot

    disko.nixosModules.disko
    ./hardware-configuration.nix
    ./install.nix

    agenix.nixosModules.default
  ];
}
