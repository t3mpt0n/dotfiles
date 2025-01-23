{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
