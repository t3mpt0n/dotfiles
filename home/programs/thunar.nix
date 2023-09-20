{
	pkgs,
	lib,
	...
}: {
	home.packages = with pkgs.xfce; [
		thunar
		thunar-volman
		thunar-media-tags-plugin
		thunar-archive-plugin
	];
}
