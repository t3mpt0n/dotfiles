inputs@ {
  self,
    hm,
    nixpkgs,
    ru-ov,
    ...
}: let
  inherit (nixpkgs.lib) nixosSystem;
  sharedModules = with self.nixosModules; [
    { home-manager.useGlobalPkgs = true; }
    hm.nixosModules.home-manager
    inputs.agenix.nixosModules.default
    core
    network
    nix
    audio
    agenix
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
in {
  t3mpt0n = nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      ./t3mpt0n
      {
        home-manager.users.jd = import ../home/profiles/t3mpt0n.nix;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs self sharedModules; };
      }
    ] ++ sharedModules ++ ru-ov_setup;
  };
}
