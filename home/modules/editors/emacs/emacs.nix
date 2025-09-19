{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    pkgs.emacs30-pgtk
    cascadia-code # Font
  ];

  xdg.configFile."emacs/early-init.el" = {
    text = ''
      ${builtins.readFile ./.early.minimal-emacs.el}
    '';
  };
  xdg.configFile."emacs/init.el" = {
    text = ''
      ${builtins.readFile ./.bootstrap.el}
      ${builtins.readFile ./.minimal-emacs.el}
      ${builtins.readFile ./ui.el}
    '';
  };
}
