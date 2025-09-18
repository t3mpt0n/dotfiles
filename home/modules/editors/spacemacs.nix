{
  pkgs,
  lib,
  ...
}:
{
  home.package = [
    pkgs.emacs30-pgtk
  ];
  xdg.configFile."emacs" = {
    enable = true;
    recursive = true;
    text = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "develop";
      hash = "";
    };
  };
}
