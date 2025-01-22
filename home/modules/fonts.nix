{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.fira-code
  ];
}
