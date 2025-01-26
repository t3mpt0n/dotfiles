let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3";
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
  users = [ jd_t3mpt0n ];
  hosts = [ t3mpt0n ];
  all = users ++ hosts;
  all_t3mpt0n = [
    jd_t3mpt0n
    t3mpt0n
  ];
in
{
  "doom1.wad.bfg.age".publicKeys = all_t3mpt0n;
  "doom2.wad.age".publicKeys = all_t3mpt0n;
  "spotify.age".publicKeys = all_t3mpt0n;
  "authinfo.age".publicKeys = all_t3mpt0n;
  "t3mpvpn.age".publicKeys = all_t3mpt0n;
  "t3mpvpn-psk.age".publicKeys = all_t3mpt0n;
  "alvpn.age".publicKeys = all_t3mpt0n;
  "alvpn.psk.age".publicKeys = all_t3mpt0n;
}
