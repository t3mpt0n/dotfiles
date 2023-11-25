{
  config,
  pkgs,
  lib,
  ...
}: let
  user_jd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3 jd@t3mpt0n";
  hostkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h root@t3mpt0n";
in {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.jd.openssh.authorizedKeys.keys = [ user_jd hostkey ];
}
