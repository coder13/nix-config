{ config, ... }:
let
  colors = config.theme.colors;
in
{
  programs.zathura = {
    enable = true;
    options = {
      default-bg = colors.primary.background;
      default-fg = colors.primary.foreground;

      completion-bg = colors.normal.black;
      completion-fg = colors.primary.foreground;
      completion-group-bg = colors.bright.green;
      completion-group-fg = colors.primary.foreground;
      completion-highlight-bg = colors.normal.green;
      completion-highlight-fg = colors.normal.black;

      inputbar-group-bg = colors.normal.black;
      inputbar-group-fg = colors.primary.foreground;

      index-bg = colors.primary.background;
      index-fg = colors.primary.foreground;
      index-active-bg = colors.bright.green;
      index-active-fg = colors.normal.white;

      highlight-color = colors.bright.yellow;
      highlight-active-color = colors.normal.blue;

      statusbar-bg = colors.primary.background;
      statusbar-fg = colors.primary.foreground;

      notification-bg = colors.normal.black;
      notification-fg = colors.normal.yellow;
      notification-error-bg = colors.normal.black;
      notification-error-fg = colors.normal.red;
      notification-warning-bg = colors.normal.black;
      notification-warning-fg = colors.normal.red;

      recolor = true;
      recolor-lightcolor = colors.normal.black;
      recolor-darkcolor = colors.bright.cyan;

      font = config.theme.font;

      statusbar-h-padding = 12;
      statusbar-v-padding = 6;
    };
  };
}