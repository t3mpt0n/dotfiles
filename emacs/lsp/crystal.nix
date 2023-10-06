  {
    self,
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      self.outputs.packages.x86_64-linux.crystalline
      crystal
    ];
  }
