{ config }: 
let
  inherit (config.lib.formats.rasi) mkLiteral;
  theme = config.theme;

  background =                  theme.colors.primary.background;
  foreground =                  theme.colors.cursor.cursor;
  bordercolor =                 background;
  separatorcolor =              theme.colors.normal.black;

  normal-background =           background;
  normal-foreground =           foreground;
  alternate-normal-background = normal-background;
  alternate-normal-foreground = normal-foreground;
  selected-normal-background =  theme.colors.normal.yellow;
  selected-normal-foreground =  theme.colors.normal.black;

  active-background =           background;
  active-foreground =           foreground;
  alternate-active-background = active-background;
  alternate-active-foreground = active-foreground;
  selected-active-background =  theme.colors.normal.yellow;
  selected-active-foreground =  theme.colors.normal.black;

  urgent-background =           background;
  urgent-foreground =           theme.colors.bright.red;
  alternate-urgent-background = background;
  alternate-urgent-foreground = urgent-foreground;
  selected-urgent-background =  theme.colors.normal.black;
  selected-urgent-foreground =  theme.colors.bright.red;
in {
  "*" = {
    border-color = mkLiteral foreground;
    background-color = mkLiteral background;
    text-color = mkLiteral foreground;
    red = theme.colors.normal.red;
    blue = theme.colors.normal.blue;
    spacing =  2;
  };

  "#window" = {
    background-color =  mkLiteral background;
    text-color = mkLiteral foreground;
    border = 1;
    padding = 5;
  };
  "#mainbox" = {
    border =  0;
    padding =  0;
  };
  "#message" = {
    border = mkLiteral "1px dash 0px 0px";
    border-color = mkLiteral separatorcolor;
    padding = mkLiteral "1px";
  };
  "#textbox" = {
    text-color = mkLiteral foreground;
  };
  "#listview" = {
    fixed-height = 0;
    border = mkLiteral "2px dash 0px 0px";
    border-color = mkLiteral separatorcolor;
    spacing = mkLiteral "2px";
    scrollbar = true;
    padding = mkLiteral "2px 0px 0px";
  };
  "#element" = {
    border = 0;
    padding = mkLiteral "1px";
  };
  "#element.normal.normal" = {
    background-color = mkLiteral normal-background;
    text-color =       mkLiteral normal-foreground;
  };
  "#element.normal.urgent" = {
    background-color = mkLiteral urgent-background;
    text-color =       mkLiteral urgent-foreground;
  };
  "#element.normal.active" = {
    background-color  = mkLiteral active-background;
    text-color        = mkLiteral active-foreground;
  };
  "#element.selected.normal" = {
    background-color  = mkLiteral selected-normal-background;
    text-color        = mkLiteral selected-normal-foreground;
  };
  "#element.selected.urgent" = {
    background-color  = mkLiteral selected-urgent-background;
    text-color        = mkLiteral selected-urgent-foreground;
  };
  "#element.selected.active" = {
    background-color  = mkLiteral selected-active-background;
    text-color        = mkLiteral selected-active-foreground;
  };
  "#element.alternate.normal" = {
    background-color  = mkLiteral alternate-normal-background;
    text-color        = mkLiteral alternate-normal-foreground;
  };
  "#element.alternate.urgent" = {
    background-color  = mkLiteral alternate-urgent-background;
    text-color        = mkLiteral alternate-normal-foreground;
  };
  "#element.alternate.active" = {
    background-color  = mkLiteral alternate-active-background;
    text-color        = mkLiteral alternate-active-foreground;
  };
  "#scrollbar" = {
    width =        mkLiteral "4px";
    border =       0;
    handle-width = mkLiteral "8px";
    padding =      0;
    handle-color = mkLiteral foreground;
  };
  "#mode-switcher" = {
    border =       mkLiteral "2px dash 0px 0px";
    border-color = mkLiteral separatorcolor;
  };
  "#button selected" = {
    background-color = mkLiteral selected-normal-background;
    text-color =       mkLiteral selected-normal-foreground;
  };
  "#inputbar" = {
    spacing =     0;
    text-color =  mkLiteral foreground;
    padding =     mkLiteral "1px";
  };
  "#case-indicator" = {
    spacing =    0;
    text-color = mkLiteral foreground;
  };
  "#entry" = {
    spacing =    0;
    text-color = mkLiteral foreground;
  };
  "#prompt" = {
    spacing =    0;
    text-color = mkLiteral foreground;
  };
  "#inputbar" = {
    children = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" "case-indicator" ];
  };
  "#textbox-prompt-colon" = {
    expand =    false;
    str =        ":";
    margin =     mkLiteral "0px 0.3em 0em 0em";
    text-color = mkLiteral foreground;
  };
  "#element-icon, element-index, element-text" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };
}
