{ pkgs, ... }:
{
  home.packages = with pkgs; [
    strawberry-qt6
  ];
}
