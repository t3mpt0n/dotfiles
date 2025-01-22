{
	plugins.none-ls = {
		enable = false;
		sources = {
			completion.luasnip.enable = true;
			diagnostics = {
				deadnix.enable = true;
				editorconfig_checker.enable = true;
				pylint.enable = true;
				statix.enable = true;
				zsh.enable = true;
			};

			formatting = {
				stylua.enable = true;
				black.enable = true;
				alejandra.enable = true;
			};

			hover = {
				dictionary.enable = true;
				printenv.enable = true;
			};
		};

		luaConfig.content = builtins.readFile ./none-ls.lua;
	};
}
