{ config }:
{
  enable = true;
  shellAliases = {
    update = "sudo nixos-rebuild switch --flake /home/caleb/.config/nix/"
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
};
