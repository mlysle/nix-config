{ ... }:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    user = "max";

    settings = {
      devices = {
        "eihwaz" = {
          id = "DCVNKFD-UIMCQED-LA3W2GF-MBBN2VQ-WMBPNZC-2YAYFI2-BHOSJPF-POPJDAZ";
        };

        # syncthing server
        "jera" = {
          id = "B7QUGFB-C74GSFK-EKRC4KK-YD5AF4E-ZBMPPLI-FZNDF3J-GUQDWW6-4GHNLAK";
        };

        "delirion" = {
          id = "FRAVFGY-HCHOFYW-EQ2ALUR-4ART3AW-25XMPQQ-LS3DMYK-5DH6GU5-CZTASAE";
        };
      };
      folders = {
        "neorg" = {
          path = "/home/max/doc/notes/neorg";
          devices = [
            "jera"
            "eihwaz"
            "delirion"
          ];
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
