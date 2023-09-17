{ config, pkgs, lib, ...}:
{
	imports = [
		./sway.nix
		./wofi.nix
		./waybar.nix
	];

	home = {
		sessionVariables = {
			SDL_VIDEODRIVER = "wayland";
			QT_QPA_PLATFORM = "wayland";
			QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
			_JAVA_AWT_WM_NONREPARENTING = "1";
			XDG_SESSION_TYPE = "wayland";
			MOZ_ENABLE_WAYLAND = "1";
		};
		packages = with pkgs; [
			grim
			slurp
			wl-clipboard
			wlr-randr
			wlogout
			xorg.libX11
			xwayland
		];
	};
}
