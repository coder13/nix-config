{ config, lib, pkgs, }:

let
  mod = "Mod4"
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      keybindings = {
        "${mod}+space" = "exec ${pkgs.dmenu}/dmenu_run";
      };
    };
    bar = {
      position = "bottom";
      output = "HDMI-0";
      tray_output = "primary";
    };
    extraConfig = lib.readFile "./i3.conf"; 
  }
}