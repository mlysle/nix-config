{
  ...
}:

{
  networking.hostName = "eihwaz";
  system.stateVersion = "25.11";

  imports = [
    ../common.nix
    ../../machines/steamdeck/hardware-configuration.nix
    ../../modules/nixos
    ../../modules/nixos/jovian.nix
  ];
}
