{
  lib,
  stdenv,
  fetchurl,
  gzip,
  ...
}: stdenv.mkDerivation rec {
  pname = "crystalline";
  version = "0.10.0";
  src = fetchurl {
    url = "https://github.com/elbywan/${pname}/releases/download/v${version}/${pname}_x86_64-unknown-linux-musl.gz";
    sha256 = lib.fakeSha256;
  };

  buildInputs = [ gzip ];
  unpackCmd = "${gzip}/bin/gzip -d $curSrc"

  installPhase = ''
    chmod u+x crystalline
    mkdir -p $out/bin
    cp -a crystalline $out/bin
  '';

  meta = with lib; {
    description = "A Language Server Protocol implementation for Crystal. 🔮";
    homepage = "https://github.com/elbywan/crystalline";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ t3mpt0n ];
  };
}
