{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [ pkgs.xfce.thunar ];
  xdg.mimeApps = lib.mkIf config.xdg.mimeApps.enable {
    defaultApplications."inode/directory" = "Thunar.desktop";
  };
}
