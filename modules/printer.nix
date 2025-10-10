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
  users.users.jd.extraGroups = [ "scanner" "lp" ];
}
