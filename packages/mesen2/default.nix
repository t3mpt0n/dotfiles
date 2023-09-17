{
	lib,
	stdenv,
	fetchFromGitHub,
	SDL2,
	dotnetCorePackages,
	clang,
	pkg-config,
	zip,
	makeWrapper,
	libGL,
	libX11,
	libXi,
	coreutils,
	findutils,
	...
}: stdenv.mkDerivation rec {
	__noChroot = true;
	pname = "mesen2";
	baseName = pname;
	version = "2.0.0";

	src = fetchFromGitHub {
		owner = "SourMesen";
		repo = "Mesen2";
		rev = "master";
		sha256 = "sha256-tttk2+B4TdARHxHOzcLdKDWY53nndq2/M9lucwaglL8=";
	};

	enableParallelBuilding = false;
	nativeBuildInputs = [ makeWrapper clang pkg-config zip SDL2.dev dotnet-sdk ];
	dotnet-sdk = dotnetCorePackages.sdk_6_0;
	dotnet-runtime = dotnetCorePackages.runtime_6_0;
	dontBuild = !stdenv.mkDerivation.enableParallelBuilding;

	installPhase = ''
		mkdir -p $out/bin
		mkdir -p $out/lib
	'';

	wrapperPath = with lib; makeBinPath [
		coreutils
		findutils
		libX11
		libX11.dev
		SDL2
		SDL2.dev
		zip
		libGL
		libXi
	];

	fixupPhase = ''
		wrapProgram $out/bin/mesen2 \
		--prefix PATH : "${wrapperPath}" \
		--prefix LD_LIBRARY_PATH : 
	'';

	meta = with lib; {
		homepage = "https://github.com/SourMesen/Mesen2";
		description = "Multi-system emulator (NES, SNES, GB, PCE) for Windows, Linux and macOS";
		license = licenses.gpl3Plus;
		maintainers = with maintainers; [t3mpt0n];
		platforms = platforms.linux;
	};
}
