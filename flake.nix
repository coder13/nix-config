{
  description = "Caleb's personal nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };

  outputs = { home-manager, nixpkgs, nixos-hardware, ... }:
    let
      hm = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [ ./user ];
      };
    in
  {
    nixosConfigurations = {
      # custom built desktop with amd ryzen 7 3700 and Nvidia GeForce GT 730 
      grogu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/grogu
          home-manager.nixosModules.home-manager
          { home-manager = hm; }
          ./system
        ];
      };

      # thinkpad-t495s laptop
      tantive = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/tantive
          home-manager.nixosModules.home-manager
          { home-manager = hm; }
          ./system
          nixos-hardware.nixosModules.lenovo-thinkpad-t495s
        ];
      };
    };
  };
}
