{
	pkgs,
	...
}: {
	imports = [
		./git.nix
		./mpd.nix
		./mpv.nix
		./pass.nix
		./dunst.nix
	];

	programs = {
		firefox = {
			enable = true;
		};
	};

	home.packages = with pkgs; [
		discord
		betterdiscordctl
		betterdiscord-installer
		corectrl /* Control AMDGPU Profiles */
		home-manager
		android-tools
		droidcam
		dotnet-sdk
	];
}
