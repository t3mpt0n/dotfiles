{
  pkgs,
  ...
}: let
  
  in {
  services.printing = {
    enable = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan
    ];
  };
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  users.users.jd.extraGroups = [ "scanner" "lp" ];
}
