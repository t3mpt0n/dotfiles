{
  pkgs,
  ...
}: {
  imports = [ ./ob-tmux.nix ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: with pkgs.emacsPackages; [
      use-package
      ligature
      undo-tree
      doom-themes
      doom-modeline
      smartparens
      vterm
      eglot
      eglot-java
      magit
      nix-mode
    ];
  };

  /* LSP Packages for Eglot */
  home.packages = with pkgs; [
    nil
    nodePackages_latest.bash-language-server
    python310Packages.jedi-language-server
    nodePackages_latest.yaml-language-server
    nodePackages_latest.vscode-html-languageserver-bin
    nodePackages_latest.vscode-css-languageserver-bin
    nodePackages_latest.vscode-json-languageserver-bin

    /* JAVA */
    jdk17
    (pkgs.jdt-language-server.overrideAttrs (oldAttrs: rec {
      fixupPhase = ''
        mv $out/bin/jdt-language-server $out/bin/jdtls
      '';
    }))

    /* LaTeX */
    (pkgs.texlive.combine {
      inherit (pkgs.texlive) scheme-basic collection-latex collection-latexextra collection-mathscience
        dvisvgm dvipng wrapfig amsmath ulem hyperref capt-of pdftex metafont pgfplots;
    })
    texlab

    /* RUST */
    rustup
  ];
}
