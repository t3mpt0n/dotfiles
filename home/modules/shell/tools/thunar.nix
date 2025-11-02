{
  lib,
  config,
  pkgs,
  ...
}: {
  options.jc'.thunar.enable = lib.mkEnableOption "thunar";

  config = lib.mkIf config.jc'.thunar.enable {
    home.packages = [ pkgs.xfce.thunar ];
    xdg.mimeApps = {
      associations.added = {
        "inode/directory" = [ "thunar.desktop" ];
      };
      defaultApplications = {
        "inode/directory" = [ "thunar.desktop" ];
      };
    };
  };
}
