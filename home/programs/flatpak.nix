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
      { appId = "ca.parallel_launcher.ParallelLauncher"; origin = "flathub"; }
      { appId = "com.github.tchx84.Flatseal"; origin = "flathub"; }
      { appId = "com.supermodel3.Supermodel"; origin = "flathub"; }
    ];

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
