{
	lib,
	config,
	pkgs,
	...
}: let
	inherit (lib) filterAttrs literalExpression optionalAttrs types;
	inherit (lib.options) mkEnableOption mkOption;
	inherit (lib.modules) mkIf mkMerge;
	cfg = config.programs.emulationstation;
	jsonFormat = pkgs.formats.json {};

	esdeSystemsOpts = { config, lib, name, ... }: with types; {
		options = {
			name = mkOption {
				type = nullOr str;
				default = "${name}";
				description = lib.mdDoc ''
					Short name of the system and the default method of sorting systems.
				'';
				example = "nes";
			};

			systemsortname = mkOption {
				type = nullOr str;
				default = null;
				description = lib.mdDoc ''
					Name that overrides `name` in EmulationStation's sorting algorithm.
				'';
			};

			fullname = mkOption {
				type = nullOr str;
				default = null;
				description = lib.mdDoc ''
					Set the fullname of the system.
				'';
				example = "Nintendo Entertainment System";
			};

			path = mkOption {
				type = nullOr str;
				default = "%ROMPATH%/${name}";
				description = lib.mdDoc ''
					Path to ROM directory.
					Not of type path because it needs to be an absolute path.
				'';
				example = "%ROMPATH%/nes";
			};

			extension = mkOption {
				type = listOf str;
				default = [ ];
				description = lib.mdDoc ''
					Acceptable file extensions for system.
				'';
				example = [ ".nes" ".NES" ".zip" ".ZIP" ".7z" ".7Z" ];
			};

			command = mkOption {
				type = attrsOf str;
				default = { };
				description = lib.mdDoc ''
					Set your emulators here.
				'';
			};

			platform = mkOption {
				type = nullOr str;
				default = "${name}";
				description = lib.mdDoc ''
					Platform name for scraping.
				'';
			};

			theme = mkOption {
				type = nullOr str;
				default = "${name}";
				description = lib.mdDoc ''
					Theme name for scraping.
				'';
			};
		};
	};

	in {
		options = {
			programs.emulationstation = with lib.types; {
				enable = mkEnableOption "Emulation Station Desktop Edition";
				package = mkOption {
					type = package;
					default = pkgs.emulationstation;
					defaultText = literalExpression "pkgs.emulationstation";
					description = lib.mdDoc ''
						EmulationStation Desktop Edition is a frontend for browsing and launching games from your multi-platform game collection.

						Available packages are:
							pkgs.emulationstation [default]
							github:t3mpt0n/dotfiles#emulationstation-de

						Set to `null` for default package.
					'';
				};

				systems = mkOption {
					type = attrsOf (submodule [esdeSystemsOpts]);
					default = { };
					description = lib.mdDoc ''
						Configure your retro systems here.
						Configuration at: https://gitlab.com/es-de/emulationstation-de/-/blob/master/INSTALL.md#es_systemsxml
					'';
					example = literalExpression ''
						"nes" = {
							 fullname = "Nintendo Entertainment System";
							 systemsortname = "01 - Nintendo Entertainment System";
							 path = "%ROMPATH%/nes";
							 extension = [ ".nes" ".NES" ".zip" ".ZIP" ".7z" ".7Z" ];
							 command = {
								label = "Mesen";
								text = "%EMULATOR_RETROARCH% -L %CORE_RETROARCH%/mesen_libretro.so %ROM%";
							 };
						 };
					'';
				};
			};
		};

		config = mkIf cfg.enable {
			home.packages = [ cfg.package ];
			home.file.".local/tmp/es_systems.json" =
				let
					cfgFile = pkgs.writeText "es.json" (builtins.toJSON cfg.systems);
					in {
						source = cfgFile;
					};

			home.activation = {
				esconvertxml = lib.hm.dag.entryAfter ["writeBoundary"] ''
					PYTHONPATH="${pkgs.python310Packages.xmltodict}/lib/python3.10/site-packages" $DRY_RUN_CMD ${lib.getExe pkgs.python3} /etc/nixos/home/custom/es-de/script/esxmlconvert.py
				'';
			};
		};
	}
