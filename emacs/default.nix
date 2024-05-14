  {
    self,
    pkgs,
    ...
  }: {
    imports = [
      ./lsp
      ./direnv.nix
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
        ];
        alwaysEnsure = true;
      })
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "NerdFontsSymbolsOnly" ]; })
      pkgs.fira-code-symbols
    ];
  }
