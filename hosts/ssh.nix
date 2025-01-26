{
  pkgs,
  ...
}:
let
  jd_t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGevSfbQaLny/CRYXKAIfCyUdDp6G3VSfz+I0sa2fFB3 jd@t3mpt0n";
  jd_aluminium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6Hbix0g/+hOemf5/ysHSVPQsujQga8g4Xfsf5ooSaA jd@aluminium";
  users = [
    jd_t3mpt0n
    jd_aluminium
  ];
  t3mpt0n = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPuI0N/XtaAXIaSoSMsL9qmuuX1VvLh9nbpB6Tzj++h root@t3mpt0n";
  aluminium = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFk0/gxpfWvEgiBGyHKkxtbwsptxanXxwLCcku67MUeE root@aluminium";
  hosts = [
    t3mpt0n
    aluminium
  ];
  everyone = users ++ hosts;
in
{
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.ssh.startAgent = true;

  users.users.jd.openssh.authorizedKeys.keys = everyone;
  users.users.root.openssh.authorizedKeys.keys = hosts;
}
