{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
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
    hack-font
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.tmux = import ./tmux.nix { inherit lib pkgs; };
  # i3 = import ./i3.nix { inherit lib pkgs; };
  # xsession.windowManager.i3 = {
  #   enable = true;
  #   package = pkgs.i3-gaps;
  #   config = {
  #     modifier = mod;

  #     keybindings = lib.mkOptionDefault {
  #       "${mod}+d" = "exec ${pkgs.dmenu}/dmenu_run";
  #     };
  #   };
  #   bar = {
  #     position = "bottom";
  #     output = "HDMI-0";
  #     tray_output = "primary";
  #   };
  #   extraConfig = lib.readFile ./i3.conf; 
  # };
}