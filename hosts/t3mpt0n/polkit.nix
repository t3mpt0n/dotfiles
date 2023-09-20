{
	pkgs,
	...
}: {
	security.polkit = {
		enable = true;
		extraConfig = ''
			polkit.addRule(function(action, subject) {
				if ((action.id == "org.corectrl.helper.init" || action.id == "org.corectrl.helperkiller.init") &&
						subject.local == true && subject.active == true && subject.isInGroup("wheel")) {
							return polkit.Result.YES;
						}
			});
		''; # -> Enter CORECTRL w/o root password
	};

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
