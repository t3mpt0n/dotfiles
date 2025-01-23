{
  lib,
  buildPythonPackage,
  fetchFromGitHub
}: buildPythonPackage rec {
  pname = "gmod-cef-codec-fix";
  version = "20230929";
  format = "other";

  src = fetchFromGitHub rec {
    owner = "solsticegamestudios";
    repo = "GModCEFCodecfix";
    rev = version;
    sha256 = lib.fakeSha256;
  };
}
