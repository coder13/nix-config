{ config, lib, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/caleb/.config/nix/";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "node" ];
      theme = "robbyrussell";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [ thefuck ];
}
