{ inputs, ... } :

{
  home.packages = [inputs.agenix.packages.x86_64-linux.default];
}
