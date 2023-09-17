{
	self,
	inputs,
	default,
	...
}: let
	module_args._module.args = {
		inherit default inputs self;
	};
	in {
		imports = [
			{
				_module.args = {
					inherit module_args; /* Pass to HM */

					sharedModules = [
						{ home-manager.useGlobalPkgs = true; }
						inputs.hm.nixosModule
						inputs.agenix.nixosModules.default
						module_args
						./core.nix
						./network.nix
						./nix.nix
						./audio.nix
						./secret.nix
					];
				};
			}
		];

		flake.nixosModules = {
			core = import ./core.nix;
			network = import ./network.nix;
			nix = import ./nix.nix;
			audio = import ./audio.nix;
			agenix = import ./secret.nix;
		};
	}
