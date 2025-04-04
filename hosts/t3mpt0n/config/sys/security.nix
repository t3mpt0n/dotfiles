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
      hyprlock = { };
    };
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
    sudo.enable = false;
  };

  programs.gnupg.agent.enable = true;
}
