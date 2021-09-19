{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {
  programs.home-manager = {
    enable = true;
  };

  home.packages = with pkgs; [
    # terminal:
    feh
    rofi
    flameshot
    neofetch
    hack-font
    R
    nodejs
    httpie
    python-with-my-packages
    ncat
    dnsutils
    bat
    miller
    powerline

    hack-font

    ruby_3_0
    jekyll

    # node:
    nodePackages.nodemon
    nodePackages.http-server

    # graphical:
    vscode
    xfce.thunar
    tdesktop
    spotify
    firefox
    audacity
    discord-canary
    google-chrome
    ledger-live-desktop
    element-desktop
    libreoffice
    slack
    thunderbird
  ];

  imports = [
    ./themes
    ./modules
    ./scripts
  ];

  xsession.initExtra = ''
    ${pkgs.xorg.xmodmap}/bin/xmodmap /home/caleb/.Xmodmap
    ${pkgs.xorg.xset}/bin/xset r rate 200 32;
  '';
}
