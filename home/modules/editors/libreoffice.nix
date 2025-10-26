{
  lib,
  config,
  pkgs,
  ...
}: {
  options.jc'.home.libreoffice.enable = lib.mkEnableOption "libreoffice";

  config = lib.mkIf config.jc'.home.libreoffice.enable {
    home.packages = [
      pkgs.libreoffice-qt-fresh
    ];
  };
}
