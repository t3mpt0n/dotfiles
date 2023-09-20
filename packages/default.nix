pargs@{ config, self', inputs', pkgs, system, ... }:
with pkgs; rec {
	wofi-pass = callPackage ./wofi-pass {};
	emulationstation-de = callPackage ./es-de {};
	simple-term-menu = python3Packages.callPackage ./simple-term-menu {};
	streamrip = python3Packages.callPackage ./streamrip { inherit simple-term-menu; };
	nestopia = callPackage ./nestopia {};
}
