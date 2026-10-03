{
  ...
}:

{
  networking.hostName = "delirion";
  system.stateVersion = "25.11";

  imports = [
    ../common.nix
    ../../machines/delirion/hardware-configuration.nix
    ../../modules/nixos
  ];
}
