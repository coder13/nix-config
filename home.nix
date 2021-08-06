{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    firefox
    audacity
  ];

  programs.home-manager = {
    enable = true;
  };
}