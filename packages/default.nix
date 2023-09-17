{
	systems = [ "x86_64-linux" ];

	perSystem = { pkgs, ... }: {
		packages = {
			wofi-pass = pkgs.callPackage ./wofi-pass {};
			emulationstation-de = pkgs.callPackage ./es-de {};
#			mesen2 = pkgs.callPackage ./mesen2 {}; # Commented out because FUCKING DOTNET!!
		};
	};
}
