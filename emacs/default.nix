{
  self,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./lsp
  ];

  nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];

  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      config = ./readme.org;
      defaultInitFile = true;
      extraEmacsPackages = epkgs: with epkgs; [
        use-package # install use-package to use in tandem w/ elpaca
      ];
      alwaysEnsure = true;
    })
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "NerdFontsSymbolsOnly" ]; })
    pkgs.fira-code-symbols
  ];
}
