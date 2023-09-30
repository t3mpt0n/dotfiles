{
	pkgs,
	inputs,
	lib,
	...
}: let
	systype = "${builtins.currentSystem}";
	in {
		# configuration shared by all hosts
		environment.systemPackages = [
			inputs.agenix.packages.x86_64-linux.agenix
			inputs.agenix.packages.x86_64-linux.doc
			pkgs.age
			pkgs.clang
			pkgs.cachix
		];

		services.cachix-agent.enable = true;

		documentation.dev.enable = true;

		i18n = {
			defaultLocale = "en_US.UTF-8";
			supportedLocales = [
				"en_US.UTF-8/UTF-8" /* AMERICAN ENGLISH */
				"es_DO.UTF-8/UTF-8" /* DOMINICAN SPANISH */
			];
		};

		hardware.opengl.enable = true;

		# necessary programs
		programs = {
			less.enable = true;
			fish.enable = true;
		};

		system = {
			copySystemConfiguration = lib.mkDefault false;
			stateVersion = lib.mkDefault "23.05";
		};

		time.timeZone = lib.mkDefault "America/New_York";

		users.users.jd = {
			isNormalUser = true;
			shell = pkgs.fish;
			extraGroups = [ "input" "video" "audio" "networkmanager" "wheel" ];
		};

		zramSwap.enable = true;
	}
