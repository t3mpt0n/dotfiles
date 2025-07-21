{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs.xfce; [
    thunar
    thunar-volman
    thunar-dropbox-plugin
    thunar-archive-plugin
    thunar-media-tags-plugin
  ];
}
