{ config, lib, pkgs, ... }:
let
  mod = "Mod4";
  fonts = {
    names = [ config.theme.font ];
    size = 10.0;
  };

  colors = config.theme.colors;

  monitors = {
    left = "DVI-D-0";
    right = "HDMI-0";
  };

  rofi-tmux = import ../../../../scripts/rofi-tmux.nix { inherit pkgs; };
  # locker = pkgs.writeScriptBin "lock" (builtins.readFile ./lock.sh);
  locker = import ./locker.nix { inherit pkgs; };
  i3exit = import ./i3exit.nix { inherit pkgs; };
  lockerMode = "System: (l) lock, (e) logout, (s) switch-user | shift: (s)uspend, (h)ibernate, (r)eboot";
  todoistMode = "Todoist (L) list, (A) add, (M) manage";
in {
  options.profiles.desktop-environment.i3 = {
    enable = lib.mkEnableOption "Enables i3 as the window manager";
  };

  config = lib.mkIf config.profiles.desktop-environment.i3.enable {
    home.packages = with pkgs; [ i3blocks ];
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
          } {
            class = "Nm-connection-editor";
          } {
            class = "flameshot";
          }];
        };

        workspaceAutoBackAndForth = true;
        focus.followMouse = false;

        fonts = fonts;

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
          { command = "bash /home/caleb/bash/xrandr.sh"; }
          { command = "feh -bg-scale /home/caleb/.background-image"; }
          { command = "picom --config /home/caleb/picom.conf"; }
          { command = "flameshot"; }
          { command = let
            killerCmd = "pgrep i3lock && xset dpms force off";
            notifierCmd = "notify-send --urgency critical -t 30 'Locking screen in 30 seconds'";
          in
            "xautolock -time 10 -locker ${locker}/bin/lock -killer \"${killerCmd}\" -killtime 10 -notify -notifer \"${notifierCmd}\""; always=true; }
        ];

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
          "${lockerMode}" = {
            "l" = "exec ${locker}/bin/lock, mode \"default\"";
            "e" = "exec ${i3exit}/bin/i3exit logout, mode \"default\"";
            "s" = "exec ${i3exit}/bin/i3exit switch_user, mode \"default\"";
            "Shift+s" = "exec ${i3exit}/bin/i3exit suspend, mode \"default\"";
            "Shift+h" = "exec ${i3exit}/bin/i3exit hibernate, mode \"default\"";
            "Shift+r" = "exec ${i3exit}/bin/i3exit reboot, mode \"default\"";

            "Return" = "mode \"default\"";
            "Escape" = "mode \"default\"";
            "${mod}+l" = "mode \"default\"";
          };
          "${todoistMode}" = {
            "l" = "exec bash ~/bash/todoist_rofi.sh list";
            "a" = "exec bash ~/bash/todoist_rofi.sh add";

            "Return" = "mode \"default\"";
            "Escape" = "mode \"default\"";
            "${mod}+q" = "mode \"default\"";
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
          "${mod}+space" = "exec rofi -show combi -modi drun";
          "${mod}+equal" = "exec rofi -show calc";
          "${mod}+p" = "exec bash ~/projects/rofi-xrandr/rofi-xrandr.sh";
          "${mod}+Shift+Return" = "exec ${rofi-tmux}/bin/rofi-tmux";
          "${mod}+Return" = "exec ${rofi-tmux}/bin/rofi-tmux";

          "${mod}+shift+q" = "kill";

          "${mod}+shift+c" = "reload";
          "${mod}+shift+r" = "restart";

          "${mod}+r" = "mode \"resize\"";
          "${mod}+l" = "mode \"${lockerMode}\"";
          "${mod}+q" = "mode \"${todoistMode}\"";

          "${mod}+grave" = "exec --no-startup-id dunstctl history-pop";

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

        colors = {
          background = colors.primary.background;
          unfocused = {
            background = colors.primary.background;
            border = colors.primary.background;
            indicator = "#ff0000";
            text = colors.primary.foreground;
            childBorder = colors.primary.background;
          };
          focused = {
            background = colors.bright.black;
            border = colors.bright.black;
            indicator = "#ff0000";
            text = colors.bright.yellow;
            childBorder = colors.bright.yellow;
          };
          focusedInactive = {
            background = colors.bright.black;
            border = colors.bright.black;
            indicator = "#ff0000";
            text = colors.normal.yellow;
            childBorder = colors.normal.yellow;
          };
          urgent = {
            background = colors.bright.red;
            border = colors.bright.red;
            indicator = "#ff0000";
            text = colors.primary.background;
            childBorder = colors.bright.red;
          };
        };

        bars = [];
        #   {
        #     fonts = fonts;
        #     position = "bottom";
        #     trayOutput = "DVI-D-0";
        #   }
        # ];
      };
    };
  };
}
