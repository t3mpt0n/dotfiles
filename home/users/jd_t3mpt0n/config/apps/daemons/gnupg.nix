{
  pkgs,
  ...
}: {
  services.gpg-agent = {
    sshKeys = [
      "6BAB375F3CDA44132CAF71A9219822384D4AD1E4" # Desktop Git Authentication Key
    ];
  };
}
