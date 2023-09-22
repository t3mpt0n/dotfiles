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
			naf = "nix flake archive /etc/nixos";
			dnrs = "doas nixos-rebuild switch --show-trace";
			nbdef = "nix-build -E 'let pkgs = import <nixpkgs> { }; in pkgs.callPackage ./default.nix {}'";
		};
		functions = {
			clear = {
				body = "vterm_printf 51;Evterm-clear-scrollback;\ntput clear;";
				onEvent = "$INSIDE_EMACS == 'vterm'";
			};
		};
	};
}
