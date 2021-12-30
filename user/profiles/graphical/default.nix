{ config, lib, pkgs, ... }:
{
  options.profiles.graphical = {
    enable = lib.mkEnableOption "Graphical Applications";
  };

  config = lib.mkIf config.profiles.graphical.enable {
    home.packages = with pkgs; [
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
      libreoffice
      #slack
      #thunderbird
      betterdiscordctl
      obsidian
      #zoom-us
      #wireshark
    ];

    # TODO: get new GPU
    services.picom = {
      enable = true;
      blur = true;
      inactiveDim = "0.3";

      fade = true;
      fadeDelta = 5;

      opacityRule = [
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        "94:class_g = 'Alacritty'"
        "94:class_g = 'Blueman-manager'"
        "94:class_g = 'discord'"
        "94:class_g = 'Zathura'"
      ];

      vSync = false;

      shadow = true;
      shadowExclude = [
        "window_type *= 'menu'"
        "name ~= 'Firefox\$'"
        "focused = 1"
      ];
      shadowOffsets = [ (-20) (-20) ];
      experimentalBackends = true;
    };
  };

  imports = [
    ./alacritty
    ./dunst
    # ./polybar
    ./rofi
    ./zathura
  ];
}