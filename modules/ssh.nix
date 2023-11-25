{
  pkgs,
  ...
}: let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3 jd@t3mpt0n";
  jd_laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIChPPQ5ZJ9g+tNkgs7kvU9Oys+8t68t1G8/WrG0a8NIi jd@t3mpt0n-laptop";
  users = [ jd_t3mpt0n jd_laptop ];
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h root@t3mpt0n";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOBdMujfYNEE0farsY5o4Ix298OvF6fULlAaJadKawue root@t3mpt0n-laptop";
  hosts = [ t3mpt0n laptop ];
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

    users.users.jd.openssh.authorizedKeys.keys = users ++ hosts;
  }
