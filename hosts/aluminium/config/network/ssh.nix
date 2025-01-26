{ lib, ... }:
let
  inherit (lib.lists) flatten;
  pubs = rec {
    jd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6Hbix0g/+hOemf5/ysHSVPQsujQga8g4Xfsf5ooSaA jd@aluminium";
    users = [ jd ];
    host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFk0/gxpfWvEgiBGyHKkxtbwsptxanXxwLCcku67MUeE root@aluminium";
    all = flatten [
      users
      host
    ];
  };
in
{

}
