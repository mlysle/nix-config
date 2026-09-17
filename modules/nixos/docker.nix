{ inputs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  users.users.max.extraGroups = [ "docker" ];
    environment.systemPackages = [ inputs.compose2nix.packages.x86_64-linux.default ];

}
