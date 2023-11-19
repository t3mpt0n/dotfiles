{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) filterAttrs literalExpression optionalAttrs types;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) imap0 flatten;
  cfg = config.programs.emulationstation;
  commandOpts = {config, lib, name, ...}: with types; {
    options = {
      cmd = mkOption {
        type = nullOr str;
        default = "";
        description = lib.mdDoc ''
          EN: Game launch command.
          ES: Commando de lanzar el juego.
        '';
        example = "nestopia --fullscreen %ROM%";
      };
      label = mkOption {
        type = nullOr str;
        default = "${name}";
        description = lib.mdDoc ''
          EN: Emulator name.
          ES: Nombre de emulador.
        '';
        example = "nestopia";
      };
    };
  };

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
        type = attrsOf (submodule [commandOpts]);
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

      emulators = mkOption {
        type = listOf package;
        default = [];
        defaultText = literalExpression "with pkgs; [nestopia ares];";
        description = lib.mdDoc ''
          EN: Same as `programs.emulationstation.emulators` but for specific systems.
          ES: Igual a `programs.emulationstation.emulators` pero para sistemas específicos.
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

      emulators = mkOption {
        type = listOf package;
        default = [];
        defaultText = literalExpression "with pkgs; [nestopia ares];";
        description = lib.mdDoc ''
          EN: General list of emulators to download.
          ES: Lista general de emuladores para descargar.
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
    home.packages =
      let
        SystemEMUS = conf:
          imap0 (n: v: v.emulators) (lib.attrValues conf);
      in [cfg.package] ++ cfg.emulators ++ (flatten (SystemEMUS cfg.systems));
    home.file.".emulationstation/custom_systems/es_systems.xml" =
      let
        confcomms = conf:
          imap0 (n: v: "<command label=\"${v.label}\">" + "${v.cmd}" + "</command>\n") (lib.attrValues conf);
        toESDE = conf:
          imap0 (n: v: "<system>\n" +
                       "<name>" + "${v.name}" + "</name>\n" +
                       (toString (confcomms v.command)) +
                       "<fullname>" + "${v.fullname}" + "</fullname>\n" +
                       "<systemsortname>" + "${v.systemsortname}" + "</systemsortname>\n" +
                       "<extension>" + "${toString v.extension}" + "</extension>\n" +
                       "<path>" + "${v.path}" + "</path>\n" +
                       "<theme>" + "${v.theme}" + "</theme>\n" +
                       "<platform>" + "${v.platform}" + "</platform>\n"
                       + "</system>\n") (lib.attrValues conf);
        systemlists = toString (toESDE cfg.systems);
        header = "<?xml version=\"1.0\" ?>\n<systemList>\n";
      in {
        text = header + systemlists + "</systemList>";
      };
  };
}
