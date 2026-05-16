{ ...} :

{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo btw I use nixOS";      
      nrs = "sudo nixos-rebuild --switch";      
    };
    initExtra = ''
      export GPG_TTY=$(tty)
      gpg-connect-agent updatestartuptty /bye > /dev/null
    '';
  };
}
