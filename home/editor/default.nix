{
	...
}: {
	imports = [
		./emacs
	];

	home.sessionVariables = {
		EDITOR = "emacsclient -c -a 'emacs'";
	};
}
