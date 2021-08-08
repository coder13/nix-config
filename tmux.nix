{ lib, pkgs, ... }:

{
  enable = true;
  escapeTime = 0;
  baseIndex = 0;
  clock24 = true;
  historyLimit = 50000;
  keyMode = "vi";
  shortcut = "a";
  terminal = "tmux-256color";
  extraConfig = lib.readFile ./tmux.conf;
}
