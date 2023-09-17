{
  description = "t3mpt0n NIX CONFIG";

	/* INPUTS */
	inputs = {
		/* NIX */
		nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

		/* FLAKE */
		flake-utils.url = "github:numtide/flake-utils";
		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};

		/* HOME MANAGER */
		hm = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		/* LANGUAGE SERVERS */
		nil = {
			url = "github:oxalica/nil";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		lsrv = {
			url = "git+https://git.sr.ht/~bwolf/language-servers.nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		/* SECRETS */
		agenix = {
			url = "github:ryantm/agenix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{self, hm, nixpkgs, ...}:
		inputs.flake-parts.lib.mkFlake { inherit inputs; } {
			imports = [
				inputs.flake-parts.flakeModules.easyOverlay
			];

			systems = [ "x86_64-linux" ];
			perSystem = pargs@{ config, self', inputs', pkgs, system, ... }: {
				packages = import ./packages pargs;
				devShells = {
					default = pkgs.mkShell {
						nativeBuildInputs = with pkgs; [
							git
							wget
							bat
							neovim
							lsb-release
							psmisc
						];
					};
				};
			};

			flake = {
				nixosConfigurations = import ./hosts inputs;
				# homeConfigurations = import ./home/profiles inputs;
				nixosModules = {
					core = import ./modules/core.nix;
					network = import ./modules/network.nix;
					nix = import ./modules/nix.nix;
					audio = import ./modules/audio.nix;
					agenix = import ./modules/secret.nix;
				};
			};
		};
}
