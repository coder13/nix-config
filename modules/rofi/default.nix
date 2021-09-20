{ config, pkgs, ... } :
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = import ./theme.nix { inherit config; };
    font = "${config.theme.font} 10";
  };
}
