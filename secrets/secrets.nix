let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3";
  jd_laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIChPPQ5ZJ9g+tNkgs7kvU9Oys+8t68t1G8/WrG0a8NIi";
  users = [ jd_t3mpt0n jd_laptop ];
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBdMujfYNEE0farsY5o4Ix298OvF6fULlAaJadKawue";
  hosts = [ t3mpt0n laptop ];
  all = users ++ hosts;
  all_laptop = [ jd_laptop laptop ];
  all_t3mpt0n = [ jd_t3mpt0n t3mpt0n ];
in {
  "nextcloud.age".publicKeys = hosts;
  "nextcloud_user.age".publicKeys = all;
  "doom1.wad.bfg.age".publicKeys = all_t3mpt0n;
  "doom2.wad.age".publicKeys = all_t3mpt0n;
  "spotify.age".publicKeys = all_t3mpt0n;
}
