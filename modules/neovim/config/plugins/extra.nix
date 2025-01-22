{pkgs, ...}: {
	extraPlugins = with pkgs.vimPlugins; [
		haskell-tools-nvim
	];
	extraPackages = with pkgs; [
		ghc
		haskellPackages.haskell-language-server
		haskellPackages.hoogle
		haskellPackages.fast-tags
		haskellPackages.haskell-debug-adapter
		nixfmt-rfc-style
		stylua
		python3Packages.black
		rustfmt
	];
	extraConfigLuaPost = ''
		${builtins.readFile ./haskell.lua}
	'';
}
