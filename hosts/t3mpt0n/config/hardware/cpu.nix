{ pkgs, ... }:
{
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  environment.systemPackages = [
    pkgs.tpm2-tools
  ];

  users.users.jd.extraGroups = [ "tss" ];
  hardware.cpu.amd.updateMicrocode = true;
}
