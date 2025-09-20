let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3";
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h";
  jd_aluminium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILK/iUVsS+pTBJwahINIzA8r5jh0UiDkAhEhfgxETcFA";
  aluminium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKX7asDVQOSlhqYu9bUyRqh92dDz8dtzu9Zv/Q+/EW75";
  users = [
    jd_t3mpt0n
    jd_aluminium
  ];
  hosts = [
    t3mpt0n
    aluminium
  ];
  everyone = users ++ hosts;
  all_t3mpt0n = [
    jd_t3mpt0n
    t3mpt0n
  ];
  all_aluminium = [
    jd_aluminium
    aluminium
  ];
in
{
  "doom1.wad.bfg.age".publicKeys = everyone;
  "doom2.wad.age".publicKeys = everyone;
}
