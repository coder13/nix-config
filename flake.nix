{
  description = "Caleb's personal nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
  };

  outputs = { home-manager, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations =
    let
      hm = {
        useGlobalPkgs = true;
        useUserPackages = true;
        # users.caleb = import ./user;
        sharedModules = [ ./user ];
      };
    in
    {
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
      # tantive = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     home-manager.nixosModules.home-manager
      #     ./hosts/tantive
      #     ./system
      #     homeConfig
      #     nixos-hardware.nixosModules.lenovo-thinkpad-t495s
      #   ];
      # };
    };
  };
}
