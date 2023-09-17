{
	pkgs,
	...
}: {
	programs.kitty = {
		enable = true;
		theme = "Gruvbox Dark Soft";
		font = {
			name = "Fira Code";
			size = 13;
			package = pkgs.fira-code;
		};
	};
}
