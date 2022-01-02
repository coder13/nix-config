{ home, lib, pkgs, ... }:
let
  calc = pkgs.writeScriptBin "calc" (import ./calc.nix { inherit pkgs; });
  rofi-tmux = pkgs.writeScriptBin "rofi-tmux" (import ./rofi-tmux.nix { inherit pkgs; });
in
{
  # home.packages = with pkgs; [ bc calc rofi-tmux ];
}