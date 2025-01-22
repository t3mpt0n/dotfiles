{
	pkgs,
	...
}: {
	programs.kitty = {
		enable = true;
		theme = "Gruvbox Dark Soft";
		font = {
			name = "MonaspiceKr Nerd Font";
			size = 16;
			package = pkgs.nerd-fonts.monaspace;
		};
		shellIntegration = {
			enableBashIntegration = true;
			enableZshIntegration = true;
			enableFishIntegration = true;
		};
	};
}
