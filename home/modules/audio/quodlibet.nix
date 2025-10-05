{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = [ pkgs.quodlibet ];
}
