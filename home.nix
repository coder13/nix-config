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

  programs.home-manager = {
    enable = true;
  };

  xresources.extraConfig = builtins.readFile (
    pkgs.fetchFromGitHub {
        owner = "solarized";
        repo = "xresources";
        rev = "025ceddbddf55f2eb4ab40b05889148aab9699fc";
        sha256 = "0lxv37gmh38y9d3l8nbnsm1mskcv10g3i83j0kac0a2qmypv1k9f";
    } + "/Xresources.dark"
  );

  imports = [
    # ./themes
    ./modules
    ./scripts
  ];
}
