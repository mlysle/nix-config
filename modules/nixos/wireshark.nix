{ pkgs, ... }:

{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.max = {
    extraGroups = [ "wireshark" ];
  };
}
