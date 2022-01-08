{ config, lib, pkgs, ... }:
{
  options.profiles.graphical = {
    enable = lib.mkEnableOption "Graphical Applications";
  };

  config = lib.mkIf config.profiles.graphical.enable {
    programs.alacritty = import ./alacritty { inherit config pkgs; };
    programs.rofi = import ./rofi { inherit config pkgs; };
    programs.zathura = import ./zathura { inherit config; };
    services.dunst = import ./dunst { inherit config pkgs; };

    home.packages = with pkgs; [
      gparted
      vscode
      xfce.thunar
      tdesktop
      spotify
      clementine
      # firefox
      # audacity
      gimp
      discord
      google-chrome
      # ledger-live-desktop
      # element-desktop
      libreoffice
      # slack
      # thunderbird
      # betterdiscordctl
      obsidian
      zoom-us
      # wireshark
    ];

    # TODO: get new GPU
    services.picom = import ./picom.nix;
  };
}
