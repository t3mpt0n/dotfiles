{
	config,
	pkgs,
	...
}: {
	services.dunst = {
		enable = true;
		package = pkgs.dunst;
		waylandDisplay = ''${if config.wayland.windowManager.sway.enable == true then "sway" else "wayland"} '';
	};
}
