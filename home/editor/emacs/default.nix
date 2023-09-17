{
	pkgs,
	...
}: {
	programs.emacs = {
		enable = true;
		package = pkgs.emacs29;
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
	services.emacs = {
		enable = false;
		package = pkgs.emacs29;
	};

	/* LSP Packages for Eglot */
	home.packages = with pkgs; [
		nil
		nodePackages_latest.bash-language-server
		python310Packages.jedi-language-server
		nodePackages_latest.yaml-language-server
		eclipses.eclipse-java
	];
}
