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
  shared_pc_modules = with self.nixosModules; [
    android
    steam
    kodi
    bluetooth
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
      inputs.chaotic.nixosModules.default
      ../emacs
      {
        home-manager.users.jd = import ../home/profiles/t3mpt0n.nix;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs self sharedModules hm_setup; };
      }
      {
        age.secrets = rec {
          doom1_wad = {
            file = ../secrets/doom1.wad.bfg.age;
            path = "/home/jd/Games/DOOM/DOOM.BFG.WAD";
            owner = "jd";
            group = "wheel";
          };
          doom2_wad = {
            file = ../secrets/doom2.wad.age;
            path = "/home/jd/Games/DOOM/DOOM2.WAD";
            owner = "jd";
            group = "wheel";
          };
          spotifyd = {
            file = ../secrets/spotify.age;
            path = "/home/jd/.local/share/spotifyd/.pwd";
            owner = "jd";
            group = "wheel";
          };
        };
      }
    ] ++ sharedModules ++ shared_pc_modules ++ ru-ov_setup ++ hm_setup;
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
