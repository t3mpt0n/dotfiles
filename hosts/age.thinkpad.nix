{
  age.secrets = {
    # Wireguard client
    tp-pk = {
      file = ../secrets/thinkpad-pk.age;
    };
    tp-psk = {
      file = ../secrets/thinkpad-psk.age;
    };
    gitea = {
      file = ../secrets/giteapass.age;
      owner = "gitea";
      group = "gitea";
    };
    gitea_cert = {
      file = ../secrets/git.t3mpt0n.com.crt.age;
      owner = "gitea";
      group = "gitea";
    };
    gitea_privkey = {
      file = ../secrets/git.t3mpt0n.com.pk.age;
      owner = "gitea";
      group = "gitea";
    };
  };
}
