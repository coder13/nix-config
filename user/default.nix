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

    notify-desktop
  ];


  imports = [
    ./profiles
    ./modules
  ];
}
