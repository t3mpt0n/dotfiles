{
	lib,
	pkgs,
	makeWrapper,
	stdenv,
	fetchFromGitHub,
	coreutils,
	python311
}: stdenv.mkDerivation rec {
	pname = "i3-alternating-layout";
	version = "unstable+2021-10-28";
	src = fetchFromGitHub {
		owner = "olemartinorg";
		repo = pname;
		rev = "master";
		sha256 = "sha256-d5POf2M16frGT8RzhC2YBhv2PgImo8djra0zJGtBVmE=";
	};

	nativeBuildInputs = [ makeWrapper ];
	dontBuild = true;

	installPhase = ''
		mkdir -p $out/bin
		cp -a alternating_layouts.py $out/bin/swayi3-alternating-layout
	'';

	wrapperPath = with lib; makeBinPath [
		coreutils
		(python311.withPackages (p: with p; [
			pip
			i3ipc
		]))
	];

	fixupPhase = ''
		patchShebangs $out/bin

		wrapProgram $out/bin/swayi3-alternating-layout \
			--prefix PATH : "${wrapperPath}" \
			--prefix PYTHONPATH : "${pkgs.python311Packages.i3ipc}/lib/python3.11/site-packages"
	'';

	meta = with lib; {
		description = " Scripts to open new windows in i3wm using alternating layouts (splith/splitv) for each new window ";
		homepage = "https://github.com/olemartinorg/i3-alternating-layout";
		license = licenses.mit;
		platforms = platforms.linux;
		maintainers = with maintainers; [ t3mpt0n ];
	};
}
