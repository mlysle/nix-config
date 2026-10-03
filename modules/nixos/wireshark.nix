{ pkgs, ... }:

{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

  users.users.max = {
    extraGroups = [ "wireshark" ];
  };
}
