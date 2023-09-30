{
	pkgs,
	self,
	...
}: {
	imports = [
		./git.nix
		./mpd.nix
		./mpv.nix
		./pass.nix
		./dunst.nix
		./thunar.nix
	];

	programs = {
		firefox = {
			enable = true;
		};
	};

	home.packages = with pkgs; [
		discord-canary
		betterdiscordctl
		betterdiscord-installer
		corectrl /* Control AMDGPU Profiles */
		home-manager
		android-tools
		droidcam
		dotnet-sdk
		self.outputs.packages.x86_64-linux.streamrip
		kid3
		pavucontrol
		keepassxc
	];
}
