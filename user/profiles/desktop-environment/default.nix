{ config, lib, pkgs, ... }:
let
  i3 = import ./i3 { inherit config lib pkgs; };
in
{
  options.profiles.desktop-environment = {
    enable = lib.mkEnableOption "Desktop environment";
  };

  config = lib.mkIf config.profiles.desktop-environment.enable {
    home.packages = with pkgs; [ compton dunst flameshot xclip xautolock scrot imagemagick ];

    xsession = {
      enable = true;
    };

    xsession.initExtra = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap /home/caleb/.Xmodmap
      ${pkgs.xorg.xset}/bin/xset r rate 200 32;
    '';
  };

  imports = [
    ./bars/polybar
    ./i3
  ];
}
