{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      colors = config.theme.colors;
      font = {
        normal.family = config.theme.font;
        bold.family = config.theme.font;
        italic.family = config.theme.font;
        size = 11.0;
      };
    };
  };
}
