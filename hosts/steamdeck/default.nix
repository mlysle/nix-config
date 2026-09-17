# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "eihwaz"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Denver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.max = {
    isNormalUser = true;
    description = "Maxwell";
    extraGroups = [ "networkmanager" "wheel" "pcscd" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses
    yubikey-personalization
    usbutils
    pcsc-tools
    pcsclite
    ccid

    imagemagick
    # kdePackages.kamoso
  ];

  services.pcscd.enable = true;

  programs.neovim.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 5353 1900 ]; 
    allowedTCPPorts = [ 8008 8009 5556 5558 ];
    allowedUDPPortRanges = [
      { from = 32768; to = 61000; }
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  hardware.gpgSmartcards.enable = true;

  services.udev.packages = [ pkgs.yubikey-personalization ];

  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
  };
  systemd.timers."sleep-and-wake" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "midnight";
        Persistent = true;
      };
  };
  
  systemd.services."sleep-and-wake" = {
    script = ''
      set -eu
      ${pkgs.util-linux}/bin/rtcwake -m mem -t $(${pkgs.coreutils}/bin/date -d "06:00" +%s)
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  programs.yubikey-touch-detector = {
    enable = true;
    libnotify = true;
  };

  programs.kdeconnect.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    mesa
  ];

  services.flatpak.enable = true;
}
