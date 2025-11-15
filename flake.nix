{
  description = "t3mpt0n NIX CONFIG";

  # INPUTS
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOs/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    catppuccin.url = "github:catppuccin/nix";

    mango.url = "github:DreamMaoMao/mango";
  };

  outputs =
    inputs@{
      self,
      sops-nix,
      hm,
      nixpkgs,
      nixpkgs-stable,
      disko,
      devenv,
      catppuccin,
      mango,
      ...
    }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      systems = [ "x86_64-linux" ];
      perSystem =
        pargs@{
          config,
            self',
            inputs',
            pkgs,
            emacs,
            system,
            ...
        }: let
          pkgs' = import nixpkgs
            {
              inherit system;
              config.allowUnfree = true;
            };
        in {
          _module.args.pkgsStable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          packages = import ./packages pkgs';
        };

      flake = {
        nixosConfigurations = import ./hosts inputs;
        nixosModules = {
          core = import ./modules/core.nix;
          network = import ./modules/network.nix;
          i2p = import ./modules/i2p.nix;
          nix = import ./modules/nix.nix;
          audio = import ./modules/audio.nix;
          agenix = import ./modules/secret.nix;
          steam = import ./modules/steam.nix;
          bluetooth = import ./modules/bluetooth.nix;
          android = import ./modules/android.nix;
          kodi = import ./modules/kodi.nix;
          gamepads = import ./modules/gamepads;
          switch = import ./modules/switch.nix;
          grub_efi = import ./modules/grub.efi.nix;
          minecraft = import ./modules/minecraft.nix;
          printer = import ./modules/printer.nix;
          gamingmice = import ./modules/gamingmice.nix;
          systemdboot = import ./modules/systemd-boot.nix;
          sudo = import ./modules/sudo.nix;
          services = import ./modules/services;
          desktop = import ./modules/desktop.nix;
        };
      };
    };
}
