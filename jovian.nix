{ inputs, ... }: {
  imports = [
    inputs.jovian.nixosModules.default
  ];

  jovian.devices.steamdeck.enable = true;
}
