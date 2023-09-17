{
	config,
	pkgs,
	fetchFromGitHub,
	lib,
	nixpkgs,
	...
}: {
	nixpkgs.config.packageOverrides = {
		 fceux = pkgs.fceux.overrideAttrs (oldAttrs: {
			 version = "2.6.6";
		 });
		};
	}
