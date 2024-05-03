{
  description = "Application packaged using poetry2nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) fetchFromGitHub fetchFromPypi lib;
        inherit (poetry2nix.lib.mkPoetry2Nix { inherit pkgs; }) mkPoetryApplication mkPoetryEnv;
      in
      {
        packages = {
          default = self.packages.${system}.streamrip;
          streamrip = mkPoetryApplication rec {
            projectDir = src;
            src = fetchFromGitHub {
              owner = "nathom";
              repo = "streamrip";
              rev = "v2.0.5";
              hash = "sha256-KwMt89lOPGt6nX7ywliG/iAJ1WnG0CRPwhAVlPR85q0=";
            };
            meta = {
              description = "A fast, all-in-one music ripper for Qobuz, Deezer, Tidal, and SoundCloud";
              license = lib.licenses.gpl3Only;
            };
            python = pkgs.python311;
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.streamrip ];
          packages = [ pkgs.poetry (mkPoetryEnv { projectDir = self; })];
        };
      });
}
