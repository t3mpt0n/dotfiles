inputs@{ self, nixpkgs, ... }:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit self inputs; };
    backupFileExtension = ".bak";
    users = {
      jd = import ../../home/users/jd_aluminium/imports.nix;
    };
  };
}
