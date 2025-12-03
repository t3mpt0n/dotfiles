{ pkgs, ... }:
{
  home.packages = with pkgs; let
    all_nerd = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  in lib.lists.flatten [
    material-design-icons
    inter
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts
    vista-fonts
    all_nerd
  ];
  
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;
    defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "Consolas" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
