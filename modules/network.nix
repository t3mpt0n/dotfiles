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
		};

		resolved.enable = true;
	};
}
