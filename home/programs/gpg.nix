{ ... } :

{
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
    publicKeys = [
      {
        source = ../max-pub.asc;
	trust = "ultimate";
      }
    ];
  };
}
