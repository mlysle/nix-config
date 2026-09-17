{ ... }:

{
  services.nfs.server = {
    enable = true;
    exports = ''
      "/home/max/media/TV Shows"    192.168.1.0/24(insecure,ro,sync,no_subtree_check,all_squash,anonuid=1001,anongid=100)
      "/home/max/media/Movies"       192.168.1.0/24(insecure,ro,sync,no_subtree_check,all_squash,anonuid=1001,anongid=100)
    '';
    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };

  networking.firewall = {
    allowedTCPPorts = [ 111  2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001  4002 20048 ];
  };
}
