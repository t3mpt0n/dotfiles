{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [ pavucontrol ];
}
