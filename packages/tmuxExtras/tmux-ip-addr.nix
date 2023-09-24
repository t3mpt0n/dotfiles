{
	lib,
	tmuxPlugins,
	fetchFromGitHub,
	...
}: tmuxPlugins.mkTmuxPlugin rec {
	pluginName = "tmux-ip-address";
	version = "unstable-2023-01-03";
	rtpFilePath = "tmux-thumbs.tmux";

	src = fetchFromGitHub {
		owner = "anghootys";
		repo = pluginName;
		rev = "3e1566827d016fa53ae2c76454afac3b6b169c52";
		sha256 = "sha256-ynTsI0l7JdrBesp2/gXhrF06OKSAcj3UYnLXEQh4rLs=";
	};

	meta = with lib; {
		description = "A plugin that shows public IP on the status bar of tmux.";
		homepage = "https://github.com/anghootys/tmux-ip-address";
		license = licenses.mit;
		platforms = platforms.unix;
		maintainers = with maintainers; [t3mpt0n];
	};
}
