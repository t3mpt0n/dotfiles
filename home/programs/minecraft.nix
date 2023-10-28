{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher-qt5
  ];
}
