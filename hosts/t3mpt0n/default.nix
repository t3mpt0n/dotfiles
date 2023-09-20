{
	pkgs,
	inputs,
	lib,
	...
}: {
	imports = [
		./hardware-configuration.nix
		./discos.nix
		./gpu.nix
		./polkit.nix
		./bluetooth.nix
		./steam.nix
		./ssh.nix
	];
	nixpkgs.config.allowUnfreePredicate = d: builtins.elem (lib.getName d) [
		"discord"
		"steam"
		"steam-run"
		"steam-original"
	];

	nix.settings.sandbox = true;

	networking.hostName = "t3mpt0n";

	boot = {
		kernelPackages = pkgs.linuxPackages_zen;
		loader = {
			efi = {
				canTouchEfiVariables = true;
				efiSysMountPoint = "/boot";
			};
			grub = {
				enable = true;
				device = "nodev";
				efiSupport = true;
				extraEntries = ''
					menuentry "Reboot" {
						reboot
					}
					menuentry "Poweroff" {
						halt
					}
				'';
			};
		};
	};

	environment.systemPackages = with pkgs; [
		neovim
		wget
		openssh
		git
		htop
		psmisc
		doas
		gnupg
		pinentry
		gnumake
		usbutils
		libgccjit
		lsb-release
		file
		lm_sensors
		(python311.withPackages (p: with p; [
			regex
			pip
			xmltodict
		]))
		polkit_gnome
		jq
		unzip
		(pkgs.SDL2.override (old: { waylandSupport = true; x11Support = false; openglSupport = true; pipewireSupport = true; }))
		appimagekit
		appimage-run
		gtk3
		gtk4
		gnome.adwaita-icon-theme
		qt5.qtwayland
		qt6.qtwayland
	];

	environment.sessionVariables = {
		DOTNET_ROOT = "${pkgs.dotnet-sdk}";
	};

	security = { /* DOAS NOT SUDO */
		doas = {
			enable = true;
			extraRules = [{
				users = [ "jd" ];
				keepEnv = true;
				persist = true;
			}];
		};
		sudo.enable = false;
		tpm2.enable = true; polkit.enable = true;};

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};

	services = {
		dbus = {
			enable = true;
			packages = with pkgs; [
				gcr
				rtkit
			];
		};
	};

	systemd.extraConfig = ''
		DefaultTimeoutStopSec=10s
	'';

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = with pkgs; [xdg-desktop-portal-gtk];
	};
}
