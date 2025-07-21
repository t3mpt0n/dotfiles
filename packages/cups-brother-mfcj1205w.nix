{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  ghostscript,
  dpkg,
  gnused,
  file,
  gnugrep,
  coreutils,
  which,
  perl
}: let
  arches = [
    "x86_64"
    "i686"
  ];
  version = "3.5.0-1";
  deb = fetchurl {
    url = "https://download.brother.com/welcome/dlf105289/mfcj1205wpdrv-${version}.i386.deb";
    sha256 = "sha256-PraHqp/OjH2yXBhlC9PJ+Edchdx3d1SXayBDGQuzd2I=";
  };
  runtimeDeps = [
    ghostscript
    perl
    file
    gnused
    which
    gnugrep
    coreutils
  ];
in stdenv.mkDerivation rec {
  pname = "cups-brother-mfcj1205w";
  inherit version;
  src = deb;
  nativeBuildInputs = [
    makeWrapper
    dpkg
    autoPatchelfHook
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    dpkg-deb -x $src $out
  ''
  + lib.concatMapStrings (arch: ''
    echo Deleting Files for ${arch}
    rm -r "$out/opt/brother/Printers/mfcj1205w/lpd/${arch}"
  '') (builtins.filter (arch: arch != stdenv.hostPlatform.linuxArch) arches)
  + ''
    ln -s \
      "$out/opt/brother/Printers/mfcj1205w/lpd/${stdenv.hostPlatform.linuxArch}/"* \
      "$out/opt/brother/Printers/mfcj1205w/lpd/"

    substituteInPlace $out/opt/brother/Printers/mfcj1205w/lpd/filter_mfcj1205w \
      --replace /opt "$out/opt" \
      --replace "my \$BR_BRT_PATH =" "my \$BR_BRT_PATH = \"$out/opt/brother/Printers/mfcj1205w\"; #" \
      --replace "PRINTER =~" "PRINTER = \"mfcj1205w\"; #"

    find "$out" -executable -and -type f | while read file; do
      wrapProgram "$file" --prefix PATH : "${lib.makeBinPath runtimeDeps}"
    done

    mkdir -p $out/lib/cups/filter
    mkdir -p $out/share/cups/model

    ln -s \
      $out/opt/brother/Printers/mfcj1205w/cupswrapper/brother_mfcj1205w_printer_en.ppd \
      $out/share/cups/model/

    chmod +x  $out/opt/brother/Printers/mfcj1205w/cupswrapper/brother_lpdwrapper_mfcj1205w
    chmod +x  $out/opt/brother/Printers/mfcj1205w/lpd/filter_mfcj1205w

    ln -s \
      $out/opt/brother/Printers/mfcj1205w/cupswrapper/brother_lpdwrapper_mfcj1205w \
      $out/lib/cups/filter/brother_lpdwrapper_mfcj1205w

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://www.brother.com";
    description = "Brother MFC-J1205W printer driver";
    license = licenses.unfree;
    platform = builtins.map (arch: "${arch}-linux") arches;
    maintainers = [ maintainers.t3mpt0n ];
  };
}
