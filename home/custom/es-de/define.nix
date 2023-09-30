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
          EN: Short name of the system and the default method of sorting systems.
          ES: Nombre corto del sistema y el metodo predeterminada para organizar sistemas.
        '';
        example = "nes";
      };

      systemsortname = mkOption {
        type = nullOr str;
        default = null;
        description = lib.mdDoc ''
          EN: Name that overrides `name` in EmulationStation's sorting algorithm.
          ES: Nombre definido por el usario que EmulationStation usa en lugar de `name`.
        '';
      };

      fullname = mkOption {
        type = nullOr str;
        default = null;
        description = lib.mdDoc ''
          EN: Set the fullname of the system.
          ES: Nombre completo del sistema.
        '';
        example = "Nintendo Entertainment System";
      };

      path = mkOption {
        type = nullOr str;
        default = "%ROMPATH%/${name}";
        description = lib.mdDoc ''
          EN: Path to ROM directory.
               Not of type path because it needs to be an absolute path.
          ES: Ruta a la directorio de ROMs.
               No de tipo path porque necesita ser una ruta absoluta.
        '';
        example = "%ROMPATH%/nes";
      };

      extension = mkOption {
        type = listOf str;
        default = [ ];
        description = lib.mdDoc ''
          EN: Acceptable file extensions for system.
          ES: Extenciones de archivos acceptables.
        '';
        example = [ ".nes" ".NES" ".zip" ".ZIP" ".7z" ".7Z" ];
      };

      command = mkOption {
        type = attrsOf str;
        default = { };
        description = lib.mdDoc ''
          EN: Set your emulators here.
          ES: Pon sus emuladores aquí.
        '';
      };

      platform = mkOption {
        type = nullOr str;
        default = "${name}";
        description = lib.mdDoc ''
          EN: Platform name for scraping.
          ES: Nombre de plataforma para raspar.
        '';
      };

      theme = mkOption {
        type = nullOr str;
        default = "${name}";
        description = lib.mdDoc ''
          EN: Theme name for scraping.
          ES: Nombre de tema para raspar.
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
            EN: EmulationStation is a frontend for browsing and launching games from your multi-platform game collection.

                Available packages are:
                pkgs.emulationstation [default]
                github:t3mpt0n/dotfiles#emulationstation-de

                Omit for default package.
            ES: EmulationStation es un interfaz para navegar y jugar sus juegos de tu colleción de juegos multiplataforma.
                Los paquetes disponibles son:
                pkgs.emulationstation [por defecto]
                github:t3mpt0n/dotfiles#emulationstation

                Omitir para usar el paquete predeterminado.
          '';
      };

      systems = mkOption {
        type = attrsOf (submodule [esdeSystemsOpts]);
        default = { };
        description = lib.mdDoc ''
            EN: Configure your retro systems here.
                Configuration at -> https://gitlab.com/es-de/emulationstation-de/-/blob/master/INSTALL.md#es_systemsxml
            ES: Configura sus sistemas retro aquí.
                Configuración a -> https://gitlab.com/es-de/emulationstation-de/-/blob/master/INSTALL.md#es_systemsxml <- Lamentablemente solo en inglés.
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
          PYTHONPATH="${pkgs.python311Packages.xmltodict}/lib/python3.11/site-packages" $DRY_RUN_CMD ${lib.getExe pkgs.python3} /etc/nixos/home/custom/es-de/script/esxmlconvert.py
        '';
    };
  };
}
