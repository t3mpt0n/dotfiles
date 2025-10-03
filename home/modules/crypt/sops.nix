{
  lib,
  pkgs,
  config,
  ...
}: {
  sops = {
    age.keyFile = "${config.xdg.dataHome}/sops/age/keys.txt";
    defaultSopsFile = ./sops.yaml;
  };
}
