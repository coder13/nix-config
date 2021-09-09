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
    alacritty
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

  programs.git = {
    enable = true;
    userName = "Caleb";
    userEmail = "choover11@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "vim";
      };
    };
  };

  programs.vim = import ./vim.nix { inherit lib pkgs; };
  programs.rofi = import ./rofi.nix { inherit pkgs; };
  programs.tmux = import ./tmux.nix { inherit lib pkgs; };

  services.polybar = import ./polybar.nix;

  imports = [
    ./i3.nix
    ./zsh.nix
  ];
}
