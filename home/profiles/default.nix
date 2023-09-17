{
	inputs,
	withSystem,
	module_args,
	...
}: let
	sharedModules = [
		../.
		module_args
	];

	homeImports = {
		"jd@t3mpt0n" = [./t3mpt0n] ++ sharedModules;
	};

	inherit (inputs.hm.lib) homeManagerConfiguration;
	in {
		imports = [
			{ _module.args = { inherit homeImports; }; }
		];

		flake = {
			homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
				"jd@t3mpt0n" = homeManagerConfiguration {
					modules = homeImports."jd@t3mpt0n";
					inherit pkgs;
				};
			});
		};
	}
