inputs: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = ".bak";
    users = {
      jd = import ../../home/users/jd_t3mpt0n/imports.nix inputs;
    };
  };
}
