{ config, ... }:

{
	networking = {
		networkmanager = {
			enable = true;
			dns = "systemd-resolved";
		};
	};

	services = {
		openssh = {
			enable = true;
			settings.UseDns = true;
			settings.PasswordAuthentication = false;
			settings.PermitRootLogin = "no";
		};

		resolved.enable = true;
	};
}
