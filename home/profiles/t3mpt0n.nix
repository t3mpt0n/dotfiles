{self, ...}: {
  imports = [
    ../programs
    ../wayland
    ../terminal
    ../custom/es-de
    ../custom/gzdoom
    ../shell
    ../.
    self.inputs.nix-flatpak.homeManagerModules.nix-flatpak
    self.inputs.nur.modules.homeManager.default
    self.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
}
