{
  lib,
  pkgs,
  config,
  ...
}: {
  xdg.configFile."niri/config.kdl".text = builtins.readFile ./config.kdl;

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
