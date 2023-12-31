{
  description = "t3mpt0n NIX CONFIG";

  /* INPUTS */
  inputs = {
    /* NIX */
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOs/nixpkgs/23.11";

    /* FLAKE */
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    /* HOME MANAGER */
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /* LANGUAGE SERVERS */
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
        flake-parts.follows = "flake-parts";
      };
    };
  };

  outputs = inputs@{self, hm, nixpkgs, flake-utils, emacs-overlay, prism_mc, nix-flatpak, ...}:
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
          nix = import ./modules/nix.nix;
          audio = import ./modules/audio.nix;
          agenix = import ./modules/secret.nix;
        };
      };
    };
}
