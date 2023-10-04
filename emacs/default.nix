{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./lsp
  ];

  nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      config = ./init.el;
      defaultInitFile = true;
      package = pkgs.emacsPgtk;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package # Install use-package to use in tandem w/ elpaca
      ];
      alwaysEnsure = true;
    })
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "NerdFontsSymbolsOnly" ]; })
    pkgs.fira-code-symbols
  ];

  services.emacs.enable = true;
}
