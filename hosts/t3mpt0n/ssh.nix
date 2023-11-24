{
  config,
  pkgs,
  lib,
  ...
}: let
  user_jd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILahBGSNQ5H0uaBpecdKd9UEJkAr+E7iB9Sty+nXxJLF jd@t3mpt0n";
  gitsignpub = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxF9lG6WbbviMHPll/TEiVspG6GX23SyCjy0vqhUQLp t3mpt0n@tutanota.com";
  hostkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h root@t3mpt0n";
in {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      UseDns = true;
      PermitRootLogin = "no";
    };
  };

  users.users.jd.openssh.authorizedKeys.keys = [ user_jd gitsignpub hostkey ];
}
