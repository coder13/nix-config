{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  home.packages = with pkgs; [
    feh
    rofi
    flameshot
    alacritty
    neofetch
    hack-font

    vscode
    xfce.thunar
    tdesktop
    spotify
    firefox
    audacity
    discord-canary
    google-chrome
    ledger-live-desktop
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.tmux = import ./tmux.nix { inherit lib pkgs; };

  imports = [
    ./i3.nix
  ];
}