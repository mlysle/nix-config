{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ... your other packages
    temurin-bin-25
  ];
}
