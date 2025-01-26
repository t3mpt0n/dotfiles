{ pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    keepassxc-go
  ];
}
