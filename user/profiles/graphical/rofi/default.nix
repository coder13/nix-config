{ config, pkgs, ... } :
{
  enable = true;
  terminal = "${pkgs.alacritty}/bin/alacritty";
  theme = import ./theme.nix { inherit config; };
  font = "${config.theme.font} 10";
  plugins = with pkgs; [
    rofi-calc
    rofi-emoji
    rofi-systemd
  ];
  extraConfig = {
    modi = "window,run,ssh,calc";
  };
}
