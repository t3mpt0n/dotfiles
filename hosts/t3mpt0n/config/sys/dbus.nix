{ pkgs, ... }:
{
  services.dbus = {
    enable = true;
    packages = with pkgs; [
      gcr
    ];
  };

  security.rtkit.enable = true;
}
