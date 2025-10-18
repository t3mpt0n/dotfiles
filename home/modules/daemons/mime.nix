{
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.mimeApps.enable = lib.mkDefault true;
}
