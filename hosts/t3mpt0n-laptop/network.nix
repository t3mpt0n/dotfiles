{
  pkgs,
  lib,
  ...
}: let
  jd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHH3YUM4sXaRr0E1C3c+MD3fRzVd4DDNZrw4+blVgrgQ jd@t3mpt0n-laptop";
  users = [ jd ];
  host = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHaj99/JEIFu2Ub4Qk3CVg/W9X2Z2e5t/bj52Rpu2ZxK root@t3mpt0n" ];
  in {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        UseDns = true;
        PermitRootLogin = "no";
      };
    };

    users.users.jd.openssh.authorizedKeys.keys = users ++ host;
  }
