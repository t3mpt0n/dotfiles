let
  sydney = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF/9uvT1quh+oWBpIlt5t4UkKXFHJgFZN+FgBVG+/BvB";
  t3mpt0n_host = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK2sOxMnaNY2TD1xLoJq3u9DG5/wKEu7g8u5xnB0XMOU";
in {
  "desktop_wg_private_key.age".publicKeys = [ sydney t3mpt0n_host ];
  "wg_psk.age".publicKeys = [ sydney t3mpt0n_host ];
}
