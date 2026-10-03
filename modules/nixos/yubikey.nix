{ pkgs, ... }:

{
  users.users.max.extraGroups = [ "pcscd" ];

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses
    yubikey-personalization
    usbutils
    pcsc-tools
    pcsclite
    ccid
  ];

  services.pcscd.enable = true;

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.debian.pcsc-lite.access_card") {
          return polkit.Result.YES;
      }
    });
    polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_pcsc") {
            return polkit.Result.YES;
        }
    });
  '';

  hardware.gpgSmartcards.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.yubikey-touch-detector = {
    enable = true;
    libnotify = true;
  };

}
