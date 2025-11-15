inputs@{
  nixpkgs,
    self,
    hm,
    nur,
    nixpkgs-stable,
    devenv,
    disko,
  catppuccin,
  mango,
    ...
}:
let
  inherit (self) nixosModules;
  inherit (nixpkgs) lib;
  imports' = lib.filter (n: lib.hasSuffix ".nix" n) (lib.filesystem.listFilesRecursive ./config);
in
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs self nixpkgs-stable; };
  modules =
    with nixosModules;
    [
      core
      network
      nix
      audio
      android
      bluetooth
      steam
      switch
      gamepads
      printer
      gamingmice
      systemdboot
      services
      desktop
      hm.nixosModules.home-manager
      nur.modules.nixos.default
      disko.nixosModules.disko
      catppuccin.nixosModules.catppuccin
      mango.nixosModules.mango
      ./home.nix
      ../crypt.nix
      ./install.nix
      {
        programs.git.enable = true;
        programs.git.config.safe.directory = "/etc/nixos";
        nixpkgs.overlays = [ inputs.prismlauncher.outputs.overlays.default ];
        environment.systemPackages = [ devenv.packages.x86_64-linux.devenv ];
        jc'.srv = {
          aria2.enable = true;
          caddy.enable = true;
        };
        users.users.jd.extraGroups = [ "aria2" ];
        services.flatpak.enable = true;
        programs.mango.enable = true;
        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;
      }
    ]
    ++ imports';
}
