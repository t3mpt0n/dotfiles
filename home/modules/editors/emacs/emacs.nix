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
      ${builtins.readFile ./modules/rss.el}
      ${builtins.readFile ./modules/emms.el}
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

  home.file = {
    ".emacs.d/tree-sitter".source = "${pkgs.emacsPackages.treesit-grammars.with-all-grammars}/lib";
  };

  home.packages = with pkgs; [
    emacsPackages.vterm
    libvterm
    emacsPackages.treesit-grammars.with-all-grammars
    
    # Dirvish dependencies
    fd
    imagemagick
    poppler
    ffmpegthumbnailer
    mediainfo

    # Needed for Org-Roam
    graphviz

    # Nix LSP
    alejandra
    nixd
    statix

    # LaTeX LSP
    texlab
    texliveFull
    auctex

    # Markdown LSP
    prettierd
    marksman
    markdownlint-cli

    # Kotlin LSP
    ktlint
    kotlin-language-server

    # C/C++/Objective-C/C# LSP
    clang
    clang-tools
    omnisharp-roslyn
    dotnet-sdk
    cmake

    # WebDev stuff
    vscode-langservers-extracted
    html-tidy

    # Rust LSP
    rust-analyzer
    rustfmt
    cargo
    rustc

    # Python LSP
    pyright
    black

    # Typst LSP
    typst
    tinymist
    typstyle
  ];
}
