{
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Brother_HL-L2460DW";
        location = "Home";
        deviceUri = "dnssd://Brother%20HL-L2460DW._ipp._tcp.local/?uuid=e3248000-80ce-11db-8000-94ddf83f03f7";
        model = "drv:///cupsfilters.drv/pwgrast.ppd";
      }
    ];
    ensureDefaultPrinter = "Brother_HL-L2460DW";
  };
}
