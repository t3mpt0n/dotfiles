{
	pkgs,
	inputs,
	self,
	...
}: {
	programs.wofi = {
		enable = true;
		package = pkgs.wofi;
	};

	home.packages = [
		inputs.self.packages.x86_64-linux.wofi-pass
	];
}
