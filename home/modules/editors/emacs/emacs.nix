{
  pkgs,
  config,
  ...
}:
{
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

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: [
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.vterm
      pkgs.mu
      epkgs.mu4e
    ];
  };

  xdg.configFile."emacs/tree-sitter" = {
    source = "${pkgs.emacsPackages.treesit-grammars.with-all-grammars}/lib";
  };
  
  systemd.user.tmpfiles.rules = if config.services.mbsync.configFile != null then [
    "L ${config.xdg.configHome}/emacs/.mbsyncrc - - - - ${config.services.mbsync.configFile}"
  ] else [];
    
  imports = [
    ./vterm_zsh.nix
  ];
}
