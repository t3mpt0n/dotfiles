{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.mime = {
    enable = true;
    addedAssociations = {
      "inode/directory" = "thunar.desktop";
    };
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
    };
  };
}
