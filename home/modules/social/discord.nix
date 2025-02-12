{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
    discord-rpc
    vesktop
  ];
}
