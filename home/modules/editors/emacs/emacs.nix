{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    emacs30-pgtk
    cascadia-code
    emacsPackages.tree-sitter
    emacsPackages.tree-sitter-langs
    emacsPackages.vterm
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient -c -a 'emacs'";
  };

  xdg.configFile."emacs/early-init.el" = {
    text = ''
      ${builtins.readFile ./.early.minimal-emacs.el}
    '';
  };
  xdg.configFile."emacs/init.el" = {
    text = ''
      ${builtins.readFile ./.bootstrap.el}
      ${builtins.readFile ./.minimal-emacs.el}
      ${builtins.readFile ./cleanup.el}
      ${builtins.readFile ./magit.el}
      ${builtins.readFile ./cmp.el}
      ${builtins.readFile ./programming.el}
      ${builtins.readFile ./shell.el}
      ${builtins.readFile ./dired.el}
      ${builtins.readFile ./ui.el}
    '';
  };

  xdg.configFile."emacs/tree-sitter" = {
    source = "${pkgs.emacsPackages.treesit-grammars.with-all-grammars}/lib";
  };

  imports = [
    ./vterm_zsh.nix
  ];
}
