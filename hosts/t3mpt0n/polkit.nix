{
	pkgs,
	...
}: {
	security.polkit.enable = true;

	systemd.user.services.polkit-gnome-authentication-agent-1 = {
		description = "Polkit GTK Authentication Agent";
		wantedBy = [ "sway-session.target" ];
		wants = [ "graphical-session.target" ];
		after = [ "sway-session.target" ];
		serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
			TimeoutStopSec = 10;
		};
	};
}
