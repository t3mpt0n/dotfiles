  {
    self,
    pkgs,
    ...
  }: {
    imports = [
      ./lsp
      ./direnv.nix
      ./sqlite.nix
    ];

    nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

    environment.systemPackages = [
      (pkgs.emacsWithPackagesFromUsePackage {
        config = ./init.el;
        defaultInitFile = true;
        package = pkgs.emacs-pgtk;
        extraEmacsPackages = epkgs: with epkgs; [
          use-package # Install use-package to use in tandem w/ elpaca
          vterm # Avoid annoying 'vterm-module' error
	  fira-code-mode
	  ligature
	  all-the-icons
	  all-the-icons-nerd-fonts
	  nerd-icons
	  nerd-icons-completion
	  emojify
	  spaceline
	  spaceline-all-the-icons
	  doom-themes
	  doom-modeline
	  counsel
	  prescient
	  ivy
	  ivy-prescient
	  ivy-rich
	  vertico
	  savehist
	  marginalia
	  shackle
	  sway
	  dashboard
	  hydra
	  which-key
	  general
	  whitespace
	  undo-tree
	  evil
	  evil-collection
	  evil-collection-mode-list
	  sudo-edit
	  tramp
	  org
	  org-contrib
	  org-roam
	  org-roam-ui
	  toc-org
	  org-bullets
	  cdlatex
	  ob-tmux
	  org-alert
	  emms
	  elfeed
	  elfeed-goodies
	  elfeed-org
	  company
	  tree-sitter
	  tree-sitter-langs
	  tree-sitter-indent
	  flycheck
	  flycheck-color-mode-line
	  magit
	  smartparens
	  rainbow-delimiters
	  yasnippet
	  eglot
	  nix-mode
	  sh-script
	  python-mode
	  robe
	  crystal-mode
	  flycheck-crystal
	  inf-crystal
	  ameba
	  flycheck-ameba
	  typst-ts-mode
	  rustic
	  eglot-java
	  c-mode
	  c++-mode
	  mhtml-mode
	  css-mode
	  js-mode
	  typescript-mode
	  go-mode
	  haskell-mode
	  nerd-icons-dired
	  peep-dired
	  dired-open
	  direnv
	  multi-vterm
	  
        ];
        alwaysEnsure = true;
      })
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.iosevka-term
      pkgs.nerd-fonts.symbols-only
      pkgs.fira-code-symbols
    ];
  }
