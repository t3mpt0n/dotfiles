{ config, pkgs, lib, self, ...}:
let
	inherit (pkgs) grim slurp wl-clipboard wlr-randr wlogout xorg xwayland;
	in {
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
				XDG_CURRENT_DESKTOP = "sway";
				MOZ_ENABLE_WAYLAND = "1";
			};

			packages = [
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
