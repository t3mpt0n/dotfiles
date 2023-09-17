inputs@ {
	self,
	hm,
	nixpkgs,
	...
}: let
		inherit (nixpkgs.lib) nixosSystem;
		sharedModules = with self.nixosModules; [
			{ home-manager.useGlobalPkgs = true; }
			hm.nixosModules.home-manager
			inputs.agenix.nixosModules.default
			core
			network
			nix
			audio
			agenix
		];
	in {
		t3mpt0n = nixosSystem {
			specialArgs = { inherit inputs self; };
			modules = [
				./t3mpt0n
				{
					home-manager.users.jd = import ../home/profiles/t3mpt0n.nix;
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.extraSpecialArgs = { inherit inputs self sharedModules; };
				}
			] ++ sharedModules;
		};
	}
