{
  ...
}:

{
  networking.hostName = "delirion";
  system.stateVersion = "25.11";

  imports = [
    ../common.nix
    ../../machines/thinkpad-e14/hardware-configuration.nix
    ../../modules/nixos
  ];
}
