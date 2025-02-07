{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      nixpkgs,
      emacs-overlay,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        flake-parts.flakeModules.easyOverlay
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              emacs-overlay.overlays.default
            ];
          };
          emacs = {
            spacemacs =
              emacsPkg:
              pkgs.emacsWithPackagesFromUsePackage {
                config = ./spacemacs/init.el;
                defaultInitFile = true;
                package = emacsPkg;
              };
          };
        in
        {
          packages = {
            spacemacs = emacs.spacemacs pkgs.emacs-pgtk;
          };
        };
    };
}
