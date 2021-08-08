{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = mod;

        keybindings = lib.mkOptionDefault {
          "${mod}+d" = "exec ${pkgs.dmenu}/dmenu_run";
        };
      };
      bar = {
        position = "bottom";
        output = "HDMI-0";
        tray_output = "primary";
      };
      extraConfig = lib.readFile ./i3.conf;
    };
}