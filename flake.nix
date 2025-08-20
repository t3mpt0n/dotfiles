{
  description = "t3mpt0n NIX CONFIG";

  # INPUTS
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/585f76290ed66a3fdc5aae0933b73f9fd3dca7e3";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOs/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    t3mpt0n_nvim = {
      type = "path";
      path = "/etc/nixos/modules/neovim/";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      hm,
      nixpkgs,
      nixpkgs-stable,
      disko,
      t3mpt0n_nvim,
      niri,
      devenv,
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
          packages = {
            xenonrecomp = import ./packages/xenon.nix pkgs';
            batocera-emulationstation = import ./packages/bemustation.nix pkgs';
            cups-brother-mfcj1205w = pkgs'.callPackage ./packages/cups-brother-mfcj1205w.nix {};
            extract-xiso = pkgs'.callPackage ./packages/extract-xiso.nix {};
          };
          devShells = {
            default = pkgs.mkShell {
              nativeBuildInputs = with pkgs; [
                git
                wget
                bat
                neovim
                lsb-release
                psmisc
              ];
            };
            python =
              let
                pypk = with pkgs.python313Packages; [
                  black
                  flake8
                  pillow
                ];
              in
              pkgs.mkShell {
                buildInputs = with pkgs; [
                  pypk
                  pyright
                ];
              };
          };
        };

      flake = {
        templates = {
          clojure = {
            path = ./templates/clojure;
            description = "Basic Clojure Template";
          };

          latex-notes = {
            path = ./templates/latex/notes;
            description = "LaTeX Note Template";
          };

          scala = {
            path = ./templates/scala;
            description = "Basic Scala Project Template";
          };
        };
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
        };
      };
    };
}
