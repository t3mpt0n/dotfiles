{
	pkgs,
	lib,
	...
}: {
	programs.fish = {
		enable = true;
		package = pkgs.fish;

		shellAbbrs = {
			ru = "rip url";
			gau = "git add -u";
			nixconf = "cd /etc/nixos";
			dnrs = "doas nixos-rebuild switch --show-trace";
		};
	};
}
