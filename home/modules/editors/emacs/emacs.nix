{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    (pkgs.emacs30.override {
      withX = false;
      withPgtk = true;
      withNativeCompilation = true;
    })
    emacsPackages.tree-sitter
    emacsPackages.tree-sitter-langs
    mu
    emacsPackages.mu4e
    emacsPackages.vterm
    multimarkdown
    marksman
    texliveFull
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
      ${builtins.readFile ./org.el}
      ${builtins.readFile ./mu4e.el}
      ${builtins.readFile ./ui.el}
    '';
  };

  xdg.configFile."emacs/tree-sitter" = {
    source = "${pkgs.emacsPackages.treesit-grammars.with-all-grammars}/lib";
  };
}
