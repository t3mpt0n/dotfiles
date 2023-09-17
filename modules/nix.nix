{ config, lib, pkgs, ... }:

{
  nix = {
  	settings = {
		experimental-features = [ "nix-command" "flakes" ];
		auto-optimise-store = true;
	};
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 30d";
		};
  };

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"discord"
	];
}
