{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            buildInputs = let
              normalPkg = with pkgs; [
                black
                yapf
                python3
                basedpyright
              ];
              
              pythonPkg = with pkgs.python313Packages; [
                jedi
                autopep8
                yapf
                ipython
                setuptools
              ];
            in normalPkg ++ pythonPkg;
          };
        };
      flake = {
      };
    };
}
