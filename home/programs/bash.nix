{ ...} :

{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo btw I use nixOS";      
      nrs = "sudo nixos-rebuild --switch";      
    };
  };
}
