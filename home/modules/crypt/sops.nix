{
  lib,
  pkgs,
  config,
  ...
}: {  
  sops = {
    age.keyFile = "${config.xdg.dataHome}/sops/age/keys.txt";
    gnupg.home = "${config.programs.gpg.homedir}";
  };
}
