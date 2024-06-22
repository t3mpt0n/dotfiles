{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          qobuz-dl = pkgs.python311Packages.buildPythonPackage rec {
            pname = "qobuz-dl";
            version = "0.9.9.10";
            src = pkgs.fetchPypi {
              inherit pname version;
              sha256 = "sha256-q7TUl3scg+isoLB0xJvJLCtvJU7O+ogMlftt0O73qb4=";
            };
            doCheck = false;
            propagatedBuildInputs = with pkgs.python311Packages; [
              requests
              pathvalidate
              mutagen
              tqdm
              beautifulsoup4
              colorama
              pick
            ];
          };
        };
      };
    };
}
