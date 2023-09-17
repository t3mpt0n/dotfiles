pargs@{ config, self', inputs', pkgs, system, ... }:
{
	wofi-pass = pkgs.callPackage ./wofi-pass {};
	emulationstation-de = pkgs.callPackage ./es-de {};
	#mesen2 = pkgs.callPackage ./mesen2 {}; # Will remove comment once dotnet actually works on nix
	streamrip = pkgs.python3Packages.callPackage ./streamrip {};
}
