{
  pkgs,
  ...
}: {
  services.flatpak = {
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      { appId = "io.github.simple64.simple64"; origin = "flathub"; }
      { appId = "com.github.Rosalie241.RMG"; origin = "flathub"; }
      { appId = "info.cemu.Cemu"; origin = "flathub"; }
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
