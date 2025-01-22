{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];
  security = {
    polkit = {
      enable = true;
    };
    pam.services = {
      swaylock.text = ''
        auth include login
      '';
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "jd" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = false;
    tpm2.enable = true;
  };

  programs.gnupg.agent.enable = true;
}
