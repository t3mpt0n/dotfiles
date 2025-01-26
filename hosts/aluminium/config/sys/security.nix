{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    doas-sudo-shim
    polkit_gnome
  ];

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };

    polkit.enable = true;
    pam = {
      services = {
        swaylock.text = ''auth include login '';
      };
    };

    sudo.enable = false;
    tpm2.enable = true;
  };

  programs.gnupg.agent.enable = true;
}
