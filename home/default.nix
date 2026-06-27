{config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
    ./services
    ./accounts
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "26.05";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
  };

  home.packages = with pkgs; [
    wget
    wl-clipboard
    #yubikey-manager
    #yubikey-personalization
  ];

  # Enable SafeEyes
  # services.safeeyes.enable = true;

  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
    publicKeys = [
      {
        source = ./max-pub.asc;
	trust = "ultimate";
      }
    ];
  };
  
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
