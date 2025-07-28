inputs: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      pkgsStable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        
        config.permittedInsecurePackages = [
          "freeimage-3.18.0-unstable-2024-04-18"
        ];
      };
    };
    backupFileExtension = ".bak";
    users = {
      jd = import ../../home/users/jd_t3mpt0n/imports.nix inputs;
    };
  };
}
