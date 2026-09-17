{ pkgs, ... }: {
  programs.gamemode.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    limo
    unityhub # for graphics programming
  ];
}
