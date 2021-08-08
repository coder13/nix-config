{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    feh
    xfce.thunar
    xclip
    rofi
    firefox
    discord-canary
    google-chrome
    flameshot
    alacritty
    neofetch
    tdesktop
    spotify
    dunst
    compton
    element-desktop
    htop
    firefox
    audacity
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.tmux = import ./tmux.nix { inherit lib pkgs; };
}