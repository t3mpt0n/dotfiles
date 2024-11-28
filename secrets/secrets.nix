let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3";
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
  jd_thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE/hzFRnWI2LVA6bauRkYPnyf4WzZne/wgFFXppDSzOA";
  thinkpad = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICh8zCIJRvQFjCsewi2elKXtTsp3JVxCVtIX+KGEM3Ba";
  users = [ jd_t3mpt0n jd_thinkpad ];
  hosts = [ t3mpt0n thinkpad ];
  all = users ++ hosts;
  all_t3mpt0n = [ jd_t3mpt0n t3mpt0n ];
  all_thinkpad = [ jd_thinkpad thinkpad ];
in {
  "doom1.wad.bfg.age".publicKeys = all_t3mpt0n;
  "doom2.wad.age".publicKeys = all_t3mpt0n;
  "spotify.age".publicKeys = all_t3mpt0n;
  "authinfo.age".publicKeys = all_t3mpt0n;
  "elfeeds.org".publicKeys = all;
  "pyload.age".publicKeys = hosts;
  "t3mpvpn.age".publicKeys = all;
  "t3mpvpn-psk.age".publicKeys = all;
  "thinkpad-pk.age".publicKeys = all;
  "thinkpad-psk.age".publicKeys = all;
  "giteapass.age".publicKeys = all;
  "git.t3mpt0n.com.crt.age".publicKeys = all;
  "git.t3mpt0n.com.pk.age".publicKeys = hosts;
  "cloudflare.creds.age".publicKeys = [ jd_t3mpt0n ] ++ hosts;
}
