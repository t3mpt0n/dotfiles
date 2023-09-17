{
	config,
	inputs,
	osConfig,
	...
}: {
	programs = {
		git = {
			enable = true;
			userEmail = "t3mpt0n@tutanota.com";
			userName = "t3mpt0n";

			signing = {
				key = "AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
				signByDefault = true;
			};

			extraConfig = {
				core = {
					editor = "emacsclient -c -a 'emacs'";
					autocrlf = "input";
				};
				init = {
					defaultBranch = "main";
				};

				color = {
					ui = "auto";
					"status" = {
						branch = "magenta";
						untracked = "cyan";
						unmerged = "yellow";
						header = "bold white";
					};
				};
				commit.gpgSign = true;
				gpg = {
					format = "ssh";
				};
			};
		};
	};
}
