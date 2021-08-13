{ lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  home.packages = with pkgs; [ compton dunst flameshot xclip ];

  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = mod;
        gaps = { smartGaps = true; };
        floating.modifier = mod;
        window.hideEdgeBorders = "smart";
        workspaceAutoBackAndForth = true;

        startup = [
          { command = "exec flameshot"; }
          { command = "exec picom"; }
        ];

        keybindings = {
          "${mod}+space" = "exec ${pkgs.dmenu}/bin/dmenu_run";
          "${mod}+Return" = "exec alacritty";

          "${mod}+shift+q" = "kill";

          "${mod}+shift+c" = "reload";
          "${mod}+shift+r" = "restart";

          # change focus with cursor keys:
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # Move windows with cursor keys:
          "${mod}+shift+Left"  = "move left";
          "${mod}+shift+Down"  = "move down";
          "${mod}+shift+Up"    = "move up";
          "${mod}+shift+Right" = "move right";

          "${mod}+bracketright" = "move workspace to output right";
          "${mod}+bracketleft" = "move workspace to output left";

          # enter fullscreen mode for the focused container
          "${mod}+shift+f" = "fullscreen toggle";

          # change container layout (stacked, tabbed, toggle split)
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          # toggle tiling / floating
          "${mod}+tab" = "floating toggle";

          # focus the parent container
          "${mod}+a" = "focus parent";

          # switch to workspace
          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+m" = "workspace M";
          "${mod}+0" = "scratchpad show";

          # move focused container to workspace
          "${mod}+shift+1" = "move container to workspace 1";
          "${mod}+shift+2" = "move container to workspace 2";
          "${mod}+shift+3" = "move container to workspace 3";
          "${mod}+shift+4" = "move container to workspace 4";
          "${mod}+shift+5" = "move container to workspace 5";
          "${mod}+shift+6" = "move container to workspace 6";
          "${mod}+shift+7" = "move container to workspace 7";
          "${mod}+shift+8" = "move container to workspace 8";
          "${mod}+shift+9" = "move container to workspace 9";
          "${mod}+shift+m" = "move container to workspace M";
          "${mod}+shift+0" = "move scratchpad";
        };
      };
      # extraConfig = lib.readFile ./i3.conf;
    };
  };
}
