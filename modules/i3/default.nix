{ config, lib, pkgs, ... }:
let
  mod = "Mod4";
  fonts = {
    names = [ config.theme.font ];
    size = 10.0;
  };

  monitors = {
    left = "DVI-D-0";
    right = "HDMI-0";
  };
in {
  home.packages = with pkgs; [ compton dunst flameshot xclip ];

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;

      terminal = "${pkgs.alacritty}/bin/alacritty";

      gaps = {
        smartGaps = true;
        smartBorders = "no_gaps";
        inner = 4;
      };

      floating = {
        modifier = mod;
        border = 2;
        criteria = [{
          class = "Pavucontrol";
        } {
          window_role = "pop-up";
        } {
          window_role = "bubble";
        } {
          window_role = "task_dialog";
        } {
          window_role = "Preferences";
        } {
          window_type = "dialog";
        } {
          window_type = "menu";
        }];
      };

      workspaceAutoBackAndForth = true;
      focus.followMouse = false;

      fonts = fonts;

      startup = [{
        command = "exec picom";
      }];

      defaultWorkspace = "1";

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

      window = {
        hideEdgeBorders = "smart";
        commands = [{
          command = "border pixel 2";
          criteria = {class = "^.*";};
        }];
      };

      assigns = {
        "2" = [
          { class = "^discord$"; }
          { class = "^Slack$"; }
          { class = "^telegram-desktop$"; }
        ];
        "M" = [
          { class = "Spotify"; }
          { class = "Rhythmbox"; }
          { class = "Clementine"; }
        ];
      };

      workspaceOutputAssign = [{
        workspace = "1";
        output = monitors.left;
      } {
        workspace = "2";
        output = monitors.right;
      } {
        workspace = "3";
        output = monitors.left;
      } {
        workspace = "4";
        output = monitors.right;
      } {
        workspace = "5";
        output = monitors.left;
      } {
        workspace = "6";
        output = monitors.right;
      } {
        workspace = "7";
        output = monitors.left;
      } {
        workspace = "8";
        output = monitors.right;
      } {
        workspace = "9";
        output = monitors.left;
      } {
        workspace = "M";
        output = monitors.right;
      }];

      keybindings = {
        "${mod}+space" = "exec ${pkgs.rofi}/bin/rofi -show run -modi combi";
        "${mod}+equal" = "exec ${pkgs.rofi}/bin/rofi -show calc -modi calc";
        "${mod}+p" = "exec bash ~/projects/rofi-xrandr/rofi-xrandr.sh";
        "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

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

        "${mod}+minus" = "split h";
        "${mod}+bar" = "split v";

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

        "XF86AudioRaiseVolume" = "exec --no-startup-id amixer set Master 2%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id amixer set Master 2%-";
        "XF86AudioMute" = "exec --no-startup-id amixer set Master toggle";
      };

      bars = [{
        fonts = fonts;
        position = "bottom";
        trayOutput = "DVI-D-0";
      }];
    };
  };
}
