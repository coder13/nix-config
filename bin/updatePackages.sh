nix flake lock --update-input nixpkgs /home/caleb/.config/nix
nixos-rebuild switch --flake /home/caleb/.config/nix

