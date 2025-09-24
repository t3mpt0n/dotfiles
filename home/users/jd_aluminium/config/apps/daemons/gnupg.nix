{
  pkgs,
  ...
}: {
  services.gpg-agent = {
    sshKeys = [
      "D59ABDBEA6527553DB9C583141D89252034F66C9" # Laptop GitHub Authentication Key
      "E0938603597A86B76C90B9CEC5189036C24C514C" # Laptop GitHub Commit Signing Key
    ];
  };
}
