{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [anki];
}
