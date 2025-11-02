{
  lib,
  config,
  pkgs,
  ...
}: let
  es-de-appimage = pkgs.appimageTools.wrapType2 {
    pname = "es-de";
    version = "3.3.0";
    src = pkgs.fetchurl {
      url = "https://gitlab.com/es-de/emulationstation-de/-/package_files/210210324/download";
      hash = "sha256-xKh5422Pk0HaMfHpZiK1yt2Mhl7TVP70OtDxA66K7go=";
    };
  };
in {
  options.jc'.gaming.frontends = {
    es-de = {
      enable = lib.mkEnableOption "es-de";
      package = lib.mkOption {
        type = lib.types.package;
        default = es-de-appimage;
        description = "EmulationStation package to use.";
      };
    };
  };

  config = let
  in {
    home.packages = [
      (lib.mkIf config.jc'.gaming.frontends.es-de.enable config.jc'.gaming.frontends.es-de.package)
    ];
  };
}
