inputs@{
  nixpkgs,
  self,
  t3mpt0n_nvim,
  ...
}:
{
  t3mpt0n = import ./t3mpt0n inputs;
  aluminium = import ./aluminium inputs;
}
