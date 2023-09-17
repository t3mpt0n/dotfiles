let
	jd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILahBGSNQ5H0uaBpecdKd9UEJkAr+E7iB9Sty+nXxJLF";
	alluser = [ jd ];

	desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
	allhosts = [ desktop ];

	all = alluser ++ allhosts;
	in {
	}
