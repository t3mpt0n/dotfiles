{
  pkgs,
  lib,
  ...
}:
{
  xdg.desktopEntries = {
    Thunar = {
      name = "Thunar";
      genericName = "File Explorer";
      exec = "Thunar %U";
      terminal = false;
      mimeType = [ "inode/directory" ];
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/https" = [ "floorp.desktop" ];
      "x-scheme-handler/http" = [ "floorp.desktop" ];
      "inode/directory" = [ "Thunar.desktop" ];
    };
  };
}
