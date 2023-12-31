{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) filterAttrs literalExpression optionalAttrs types mdDoc;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.lists) imap0 flatten;
  cfg = config.programs.gzdoom;
  iWadOpts = { config, lib, ...}: with types; {
    options = {
      path = mkOption {
        type = nullOr str;
        default = null;
        description = mdDoc ''
        EN: Path to your DOOM WAD.
        ES: Dirección a tú DOOM WAD.
      '';
        example = "/run/agenix.d/DOOM.BFG.WAD";
      };
    };
  };
  in {
    options = {
      programs.gzdoom = with lib.types; {
        enable = mkEnableOption "GZDoom";
        package = mkOption {
          type = package;
          default = pkgs.gzdoom;
          defaultText = literalExpression "pkgs.gzdoom";
          description = mdDoc ''
            EN: GZDoom is a popular source port for Classic DOOM and many, many WAD packs and mods.
            ES: GZDoom es un puerto de fuente popular para DOOM classico y tambien muchos, muchos paquetes de WADs y modificaciones.
          '';
        };

        DOOMWADDIR = mkOption {
          type = str;
          default = "";
          inherit (iwadOpts.options.path) description;
        };

        iWads = mkOption {
          type = attrsOf (submodule [iWadOpts]);
          default = { };
          description = mdDoc ''
            EN: Your personal list of DOOM IWADS.
            ES: Lista personal de IWADS de DOOM.
          '';
          example = literalExpression ''
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = [ cfg.package ];
      home.sessionVariables = { DOOMWADDIR = "${cfg.DOOMWADDIR}"; };
    };
  }
