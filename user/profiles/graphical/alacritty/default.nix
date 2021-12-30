{ pkgs, config, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      colors = {
        inherit (config.theme.colors) primary normal bright;
        cursor = {
          text = "CellBackground";
          cursor = "CellForeground";
        };
      };
      font = {
        normal.family = config.theme.font;
        bold.family = config.theme.font;
        italic.family = config.theme.font;
        size = 11.0;
      };
      live_config_reload = true;
    };
  };
}
