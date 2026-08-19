{ inputs, ... }: {
  imports = [
    inputs.jovian.nixosModules.default
  ];

  jovian.devices.steamdeck.enable = true;

  jovian.steam = {
    enable = true;
    user = "max";
    autoStart = true;
    desktopSession = "plasma";
  };
}
