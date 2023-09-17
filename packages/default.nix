pargs@{ config, self', inputs', pkgs, system, ... }:
rec {
	wofi-pass = pkgs.callPackage ./wofi-pass {};
	emulationstation-de = pkgs.callPackage ./es-de {};
	#mesen2 = pkgs.callPackage ./mesen2 {}; # Will remove comment once dotnet actually works on nix
	simple-term-menu = pkgs.python3Packages.callPackage ./simple-term-menu {};
	streamrip = pkgs.python3Packages.callPackage ./streamrip {inherit simple-term-menu; };
}
