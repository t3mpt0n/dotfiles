{
  self,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [ (import self.inputs.ru-ov.overlays.default) ];
  environment.systemPackages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-src" ];
    })
    rust-analyzer-unwrapped
  ];
}
