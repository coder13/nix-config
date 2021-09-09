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

        gaps = {
          smartGaps = true;
          smartBorders = "no_gaps";
        };

        floating = {
          modifier = mod;
          border = 2;
          criteria = [{
            class = "Pavucontrol";
          }];
        };

        window.hideEdgeBorders = "smart";
        workspaceAutoBackAndForth = true;
        focus.followMouse = false;

        fonts = {
          names = [ "monospace 8" ];
          size = 8.0;
        };

        startup = [
          { command = "exec flameshot"; }
          { command = "exec picom"; }
        ];

        modes = {
          resize = {
            "Left" = "resize shrink width 5 px or 5 ppt";
            "Down" = "resize grow height 5 px or 5 ppt";
            "Up" = "resize shrink height 5 px or 5 ppt";
            "Right" = "resize grow width 5 px or 5 ppt";

            "ctrl+Left" = "resize shrink width 10 px or 10 ppt";
            "ctrl+Down" = "resize grow height 10 px or 10 ppt";
            "ctrl+Up" = "resize shrink height 10 px or 10 ppt";
            "ctrl+Right" = "resize grow width 10 px or 10 ppt";

            "shift+Left" = "resize shrink width 1 px or 1 ppt";
            "shift+Down" = "resize grow height 1 px or 1 ppt";
            "shift+Up" = "resize shrink height 1 px or 1 ppt";
            "shift+Right" = "resize grow width 1 px or 1 ppt";

            "Return" = "mode \"default\"";
            "Escape" = "mode \"default\"";
            "${mod}+r" = "mode \"default\"";
          };
        };

        keybindings = {
          "${mod}+space" = "exec rofi -show combi -modi drun";
          "${mod}+Return" = "exec alacritty";

          "${mod}+shift+q" = "kill";

          "${mod}+shift+c" = "reload";
          "${mod}+shift+r" = "restart";

          "${mod}+r" = "mode \"resize\"";

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
          "${mod}+Tab" = "floating toggle";

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

          "XF86AudioRaiseVolume" = "exec --no-startup-id paxmixer -increase 5";
          "XF86AudioLowerVolume" = "exec --no-startup-id paxmixer -decrease 5";
          "XF86AudioMute" = "exec --no-startup-id paxmixer --toggle-mute";
        };
        bars = [{
          position = "bottom";
          trayOutput = "DVI-D-0";
        }];
      };
      # extraConfig = lib.readFile ./i3.conf;
    };
  };
}
