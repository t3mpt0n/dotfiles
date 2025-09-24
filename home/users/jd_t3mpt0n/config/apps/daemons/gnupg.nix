{
  pkgs,
  ...
}: {
  services.gpg-agent = {
    sshKeys = [
      "6BAB375F3CDA44132CAF71A9219822384D4AD1E4" # Desktop Git Authentication Key
      "069B2DEEF37B5CD10F1D6B5814F2E9E1F75FC57D" # Desktop Git Commit Key
    ];
  };
}
