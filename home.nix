{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
  ]; 
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {
  home.packages = with pkgs; [
    feh
    rofi
    flameshot
    alacritty
    neofetch
    hack-font
    R
    nodejs
    python-with-my-packages

    vscode
    xfce.thunar
    tdesktop
    spotify
    firefox
    audacity
    discord-canary
    google-chrome
    ledger-live-desktop
    libreoffice
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.tmux = import ./tmux.nix { inherit lib pkgs; };

  imports = [
    ./i3.nix
  ];
}
