{
  description = "My NixOS system";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    legacyfox = {
      url = "git+https://git.gir.st/LegacyFox.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, jovian, home-manager, legacyfox, ... }@inputs: {
    nixosConfigurations.sigismund = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix

        ./jovian.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.max = import ./home;
        }
      ];
    };
  };
}
