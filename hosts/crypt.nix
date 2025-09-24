{
  pkgs,
  ...
}: {
  services = {
    openssh = {
      enable = true;
      startWhenNeeded = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };  
    };
  };

  users.users.jd.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/9uvT1quh+oWBpIlt5t4UkKXFHJgFZN+FgBVG+/BvB (none)"
  ];
}
