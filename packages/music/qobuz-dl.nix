{ pkgs, lib, ... }:
pkgs.python314Packages.buildPythonPackage rec {
  pname = "qobuz-dl";
  version = "0.9.9.10";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "sha256-q7TUl3scg+isoLB0xJvJLCtvJU7O+ogMlftt0O73qb4=";
  };
  doCheck = false;
  propagatedBuildInputs = with pkgs.python314Packages; [
    requests
    pathvalidate
    mutagen
    tqdm
    beautifulsoup4
    colorama
    pick
  ];
}
