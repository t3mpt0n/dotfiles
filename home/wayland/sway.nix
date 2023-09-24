{
	config,
	lib,
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		swaybg
		swayidle
		swaylock
	];

	wayland.windowManager.sway = {
		enable = true;
		xwayland = true;
		config = rec {
			modifier = "Mod4";
			output = let
				walldir = "/mnt/dhp/media/Images/Wallpaper/";
				res0 = "1680x1050";
				res1 = "2560x1440";
				mon0 = "HDMI-A-1"; /* DELL SP2009W [VGA] */
				mon1 = "DP-3"; /* SAMSUNG ODYSSEY G50A */
				in {
					"${mon0}" = {
						mode = "${res0}@60Hz";
						position = "0,320";
						bg = "${walldir}${res0}/Ginger\ Bread.jpg fill";
					};
					"${mon1}" = {
						mode = "${res1}@165Hz";
						position = "1680,0";
						bg = "${walldir}${res1}/Sunshine\ Reggae.png fill";
						adaptive_sync = "on";
					};
				};
			bars = [ ]; /* empty bc I'm gonna specify waybar in extraConfig */
			keybindings = with lib;
				let
					modifier = config.wayland.windowManager.sway.config.modifier;
				in mkOptionDefault {
					"${modifier}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty";
					"${modifier}+Shift+q" = "kill";
					"${modifier}+p" = "exec ${pkgs.wofi}/bin/wofi --show run";
					"${modifier}+e" = "exec ${pkgs.emacs29-pgtk}/bin/emacsclient -c -a 'emacs'";
					"${modifier}+Shift+d" = "exec ${pkgs.discord}/bin/discord";
					"${modifier}+w" = "exec ${pkgs.firefox}/bin/firefox";
					"${modifier}+Shift+P" = "exec wofi-pass";
					"${modifier}+Alt+w" = "layout tabbed";
					"${modifier}+Alt+e" = "layout toggle split";
					"${modifier}+Alt+v" = "splitv";
					"${modifier}+Alt+h" = "splith";
					"${modifier}+Alt+Tab" = "input type:keyboard xkb_switch_layout next";
					"${modifier}+Alt+L" = "swaylock -c 000000";
					"XF86AudioLowerVolume" = "exec amixer sset Master 5%-";
					"XF86AudioRaiseVolume" = "exec amixer sset Master 5%+";
					"XF86AudioMute" = "exec amixer sset Master toggle";
				};
			startup = [
				{ command = "emacs --daemon"; }
				{ command = "corectrl"; }
				{ command = "nix flake archive /etc/nixos"; always = true; }
			];
			input = {
				"type:keyboard" = {
					xkb_layout = "us,us_intl";
				};
			};
		};
		extraConfig = ''
			default_border pixel 5
			bar {
				swaybar_command waybar
			}
		'';
	};
}
