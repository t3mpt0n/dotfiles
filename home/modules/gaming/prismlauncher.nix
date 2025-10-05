{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  home.packages = [ pkgs.prismlauncher ];
}
