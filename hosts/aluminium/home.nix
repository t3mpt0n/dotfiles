inputs: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtenension = ".bak";
    users = {
      jd = import ../../home/users/jd_aluminium/imports.nix inputs;
    };
  };
}
