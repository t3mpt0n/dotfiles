{
	inputs,
	sharedModules,
	homeImports,
	...
}: {
	flake.nixosConfigurations = let
		inherit (inputs.nixpkgs.lib) nixosSystem;
		in {
			t3mpt0n = nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./t3mpt0n
					{ home-manager.users.jd.imports = homeImports."jd@t3mpt0n"; }
					{ home-manager.extraSpecialArgs = { inherit inputs; }; }
				] ++ sharedModules;
			};
		};
	}
