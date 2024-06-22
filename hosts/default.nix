inputs@ {
    self,
    hm,
    nixpkgs,
    nixpkgs-stable,
    ru-ov,
    nix-flatpak,
    prism_mc,
    disko,
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
    kodi
    bluetooth
  ];
  hm_setup = [
    { home-manager.useGlobalPkgs = true; }
    hm.nixosModules.home-manager
  ];
  gaming_setup = with self.nixosModules; [
    steam
    gamepads
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

  prismlauncher = [
    ({pkgs, ...}: {
      nixpkgs.overlays = [ prism_mc.overlays.default ];
      environment.systemPackages = [ pkgs.prismlauncher ];
    })
  ];
in {
  t3mpt0n = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      ./t3mpt0n
      inputs.chaotic.nixosModules.default
      inputs.nur.nixosModules.nur
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
          authinfo = {
            file = ../secrets/authinfo.age;
            path = "/home/jd/.authinfo";
            owner = "jd";
            group = "wheel";
          };
          elfeed = {
            file = ../secrets/elfeeds.org;
            path = "/home/jd/.emacs.d/elfeed.org";
            owner = "jd";
            group = "wheel";
          };
          pyload = {
            file = ../secrets/pyload.age;
          };
        };
      }
    ]
    ++ sharedModules
    ++ shared_pc_modules
    ++ gaming_setup
    ++ ru-ov_setup
    ++ hm_setup
    ++ prismlauncher;
  };

  t3mpt0n-laptop = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.disko.nixosModules.disko
      ./t3mpt0n-laptop
    ] ++ sharedModules;
  };

  t3mpt0n-thinkpad = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.disko.nixosModules.disko
      ./t3mpt0n-thinkpad
      ./age.thinkpad.nix
    ]
    ++ sharedModules;
  };
}
