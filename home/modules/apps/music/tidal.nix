{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-dl
    tidal-hifi
  ];
}
