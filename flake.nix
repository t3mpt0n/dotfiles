{
  description = "t3mpt0n NIX CONFIG";

  /* INPUTS */
  inputs = {
    /* NIX */
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOs/nixpkgs/23.11";
    nur.url = "github:nix-community/NUR";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /* FLAKE */
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    homebrew = {
      url = "/etc/nixos/packages/homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gaming = {
      url = "/etc/nixos/packages/gaming";
      inputs = {
       nixpkgs.follows = "nixpkgs";
       flake-utils.follows = "flake-utils";
      };
    };
    music = {
      url = "/etc/nixos/packages/music";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /* HOME MANAGER */
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "hm";
      };
    };

    /* PROGRAMMING */
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clj-lsp = {
      url = "github:clojure-lsp/clojure-lsp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ru-ov = {
      url = "github:oxalica/rust-overlay";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gitea = {
      url = "github:go-gitea/gitea";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };


    /* SECRETS */
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /* EMACS */
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    /* FLATPAK */
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    /* GAMING */
    prism_mc = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = inputs@{self, hm, nixpkgs, flake-utils, emacs-overlay, prism_mc, nix-flatpak, disko, gitea, plasma-manager, ...}:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      systems = [ "x86_64-linux" ];
      perSystem = pargs@{ config, self', inputs', pkgs, system, ... }: {
        packages = import ./packages pargs;
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
        };
      };

      flake = {
        nixosConfigurations = import ./hosts inputs;
        # homeConfigurations = import ./home/profiles inputs;
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
        };
      };
    };
}
