{
	lib,
	inputs,
	pkgs,
	self,
	...
}: let
	inherit (pkgs) fetchFromGitHub punes ares;
	fceux = (pkgs.fceux.overrideAttrs (oldAttrs: rec {
		version = "2.6.6";
		src = fetchFromGitHub {
			owner = "TASEmulators";
			repo = "fceux";
			rev = "v${version}";
			sha256 = "sha256-Wp23oLapMqQtL2DCkm2xX1vodtEr/XNSOErf3nrFRQs=";
		};
	}));
	emulators.nes = [ fceux punes ];
	emulators.multi = [ ares ];
	in rec {
	programs.emulationstation = {
		enable = true;
		package = self.outputs.packages.x86_64-linux.emulationstation-de;
		systems = let
			rompath = "/mnt/dhp/media/Games/ROMs";
			commonExtensions = [ ".7z" ".7Z" ".zip" ".ZIP" ];
			in {
				"nes" = {
					fullname = "Nintendo Entertainment System";
					systemsortname = "01 - Nintendo Entertainment System";
					extension = [ ".nes" ".NES" ] ++ commonExtensions;
					path = "${rompath}/NES";
					command = {
						label = "ares";
						text = "ares --fullscreen --system Famicom %ROM%";
					};
				};
				"snes" = {
					fullname = "Super Nintendo Entertainment System";
					systemsortname = "02 - Super Nintendo Entertainment System";
					extension = [ ".smc" ".SMC" ".sfc" ".SFC" ] ++ commonExtensions;
					path = "${rompath}/SNES";
					command = {
						label = "BSNES";
						text = "balls";
					};
				};
			};
	};

	home.packages = with emulators;
		nes ++ multi;
}
