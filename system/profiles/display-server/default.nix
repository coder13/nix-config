{ config, lib, pkgs, ... }:
let

in {
  options.profiles.display-server = {
    enable = lib.mkEnableOption "X11 Display Server";
  };

  config = lib.mkIf config.profiles.display-server.enable {
    # environment.systemPackages = with pkgs; [ xorg.xmodmap ];
    services.xserver = {
      enable = true;

      # TODO: figure out the minimum times these x session commands need to be mentioned. It is currently mentioned twice
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xmodmap}/bin/xmodmap ~/.Xmodmap
        ${pkgs.xorg.xset}/bin/xset r rate 200 32
      '';

      # TODO: Make dynamic so that any window manager can be loaded provided it has a profile
      windowManager.i3.enable = true;
    };
  };
}
