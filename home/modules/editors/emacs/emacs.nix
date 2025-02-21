{pkgs, ...}: {
  home.file.".emacs.d/early-init.el" = {
    text = ''
      ;Disable package.el
      (setq package-enable-at-startup nil)
    '';
  };
  home.file.".emacs.d/init.el" = {
    text = ''
      ${builtins.readFile ./modules/elpaca.el}
      ${builtins.readFile ./modules/keys.el}
      ${builtins.readFile ./modules/ui.el}
      ${builtins.readFile ./modules/dashboard.el}
      ${builtins.readFile ./modules/cmp.el}
      ${builtins.readFile ./modules/org.el}
      ${builtins.readFile ./modules/terminal.el}
      ${builtins.readFile ./modules/dirvish.el}
      ${builtins.readFile ./modules/lsp.el}
      ${builtins.readFile ./modules/magit.el}
    '';
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  services.emacs = {
    enable = false;
    client = {
      enable = true;
      arguments = [
        "-c"
        "-a 'emacs'"
      ];
    };
    defaultEditor = true;
    package = pkgs.emacs30-pgtk;
  };

  home.packages = with pkgs; [
    # Dirvish dependencies
    fd
    imagemagick
    poppler
    ffmpegthumbnailer
    mediainfo

    # Nix LSP
    alejandra
    nixd

    # LaTeX LSP
    texlab
    texliveFull
    auctex

    # Markdown LSP
    prettierd
    marksman
  ];
}
