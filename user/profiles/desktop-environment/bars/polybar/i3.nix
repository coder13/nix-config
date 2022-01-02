{ colors }: {
  type = "internal/i3";
  pin-workspaces = true;
  strip-wsnumbers = true;
  index-sort = false;
  enable-click = true;
  enable-scroll = true;
  wrapping-scroll = false;
  reverse-scroll = true;
  fuzzy-match = true;
  # label-dimmed-underline = ${root.background}

  ws-icon-default = "";

  # Available tags:
  #   <label-state> (default) - gets replaced with <label-(focused|unfocused|visible|urgent)>
  #   <label-mode> (default)
  format = "<label-state> <label-mode>";

  # Available tokens:
  #   %mode%
  # Default: %mode%
  label-mode = " [%mode%] ";
  label-mode-background = colors.bright.red;
  label-mode-foreground = colors.primary.background;

  # Available tokens:
  #   %name%
  #   %icon%
  #   %index%
  #   %output%
  # Default: %icon%  %name%
  label-focused = "%name%";
  label-focused-foreground = colors.bright.yellow;
  label-focused-background = colors.bright.black;
  label-focused-padding = 1;

  # Available tokens:
  #   %name%
  #   %icon%
  #   %index%
  #   %output%
  # Default: %icon%  %name%
  label-unfocused = "%name%";
  label-unfocused-padding = 1;

  # Available tokens:
  #   %name%
  #   %icon%
  #   %index%
  #   %output%
  # Default: %icon%  %name%
  label-visible = "%name%";
  label-visible-foreground = colors.normal.yellow;
  label-visible-background = colors.normal.black;
  label-visible-padding = 1;

  # Available tokens:
  #   %name%
  #   %icon%
  #   %index%
  #   %output%
  # Default: %icon%  %name%
  label-urgent = "%name%";
  label-urgent-foreground = colors.bright.red;
  label-urgent-background = colors.primary.background;
  label-urgent-padding = 1;
}