echo "Updating flake.lock nixpkgs"
nix flake lock --update-input nixpkgs /home/caleb/.config/nix
echo "Updating flake.lock home-manager"
nix flake lock --update-input home-manager /home/caleb/.config/nix

read -p "rebuild nixos? " -i y option

if [[ $option == "y" || $option == "Y" ]]; then
  nixos-rebuild switch --flake /home/caleb/.config/nix
fi

