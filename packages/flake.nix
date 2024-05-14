{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    homebrew = {
      url = "/etc/nixos/packages/homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gaming = {
      url = "/etc/nixos/packages/gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    qobuz-dl = {
      url = "/etc/nixos/packages/qobuz-dl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      systems = [ "x86_64-linux" ];
      perSystem = pargs@{ config, self', inputs', pkgs, system, ... }: {
        packages = import ./. pargs;
      };
    };
}
