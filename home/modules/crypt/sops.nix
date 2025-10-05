{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {  
  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    age.sshKeyPaths = [ "${osConfig.sops.secrets.sydney_id.path}" ];
    gnupg.home = "${config.programs.gpg.homedir}";
  };
}
