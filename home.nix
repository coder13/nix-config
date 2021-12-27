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
    # rofi
    neofetch
    hack-font
    # R
    nodejs
    httpie
    python-with-my-packages
    ncat
    dnsutils
    bat
    miller
    powerline
    unzip
    gcc
    docker-compose
    cargo
    #mtools
    #dosfstools
    jq
    todoist
    git-ignore
    csvtool

    ruby_3_0
    #jekyll

    # node:
    nodePackages.nodemon
    nodePackages.http-server
    nodePackages.eslint

    # graphical:
    gparted
    vscode
    xfce.thunar
    tdesktop
    spotify
    clementine
    #firefox
    #audacity
    gimp
    discord
    google-chrome
    #ledger-live-desktop
    #element-desktop
    #libreoffice
    #slack
    #thunderbird
    betterdiscordctl
    obsidian
    #zoom-us
    #wireshark
  ];

  # TODO: get new GPU
  # services.picom = {
  #   enable = true;
  #   blur = true;
  #   inactiveDim = "0.3";

  #   fade = true;
  #   fadeDelta = 10;

  #   opacityRule = [
  #     "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
  #     "94:class_g = 'Alacritty'"
  #     "94:class_g = 'Blueman-manager'"
  #     "94:class_g = 'discord'"
  #     "94:class_g = 'Zathura'"
  #   ];

  #   vSync = false;

  #   shadow = true;
  #   shadowExclude = [
  #     "window_type *= 'menu'"
  #     "name ~= 'Firefox\$'"
  #     "focused = 1"
  #   ];
  #   shadowOffsets = [ (-20) (-20) ];
  #   experimentalBackends = true;
  # };

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
