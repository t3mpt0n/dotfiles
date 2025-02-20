{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.fira-code
    nerd-fonts._3270
    nerd-fonts.blex-mono
    nerd-fonts.geist-mono
    inter
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
}
