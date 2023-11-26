inputs@ {
    self,
    hm,
    nixpkgs,
    nixpkgs-stable,
    ru-ov,
    nix-flatpak,
    ...
}: let
  inherit (nixpkgs.lib) nixosSystem;
  system = "x86_64-linux";
  sharedModules = with self.nixosModules; [
    inputs.agenix.nixosModules.default
    core
    network
    nix
    audio
    agenix
  ];
  hm_setup = [
    { home-manager.useGlobalPkgs = true; }
    hm.nixosModules.home-manager
  ];
  ru-ov_setup = [
    ({pkgs, ...}: {
      nixpkgs.overlays = [ inputs.ru-ov.overlays.default ];
      environment.systemPackages = [
        (pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" ];
        })
        pkgs.rust-analyzer-unwrapped
      ];
    })
  ];
 overlay-2305 = final: prev: {
   stable = nixpkgs-stable.legacyPackages.${prev.system};
 };
in {
  t3mpt0n = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      ./t3mpt0n
      ../emacs
      {
        home-manager.users.jd = import ../home/profiles/t3mpt0n.nix;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs self sharedModules hm_setup; };
      }
    ] ++ sharedModules ++ ru-ov_setup ++ hm_setup;
  };

  t3mpt0n-laptop = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      ({config, pkgs, ...}: { nixpkgs.overlays = [ overlay-2305 ]; })
      ./t3mpt0n-laptop
      {
        home-manager.users.jd = import ../home/profiles/t3mpt0n-laptop.nix;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs self sharedModules hm_setup; };
      }
      {
        age.secrets = {
          nextcloud = {
            file = ../secrets/nextcloud.age;
            owner = "nextcloud";
            group = "nextcloud";
          };
          nextcloud_jd = {
            file = ../secrets/nextcloud_user.age;
            owner = "nextcloud";
            group = "nextcloud";
          };
        };
      }
    ] ++ sharedModules ++ hm_setup;
  };
}
