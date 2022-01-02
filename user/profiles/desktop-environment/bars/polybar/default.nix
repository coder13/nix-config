{ config, lib, pkgs, ... }:
let
  colors = config.theme.colors;
in
{
  options.profiles.desktop-environment.bars.polybar = {
    enable = lib.mkEnableOption "Enables polybar";
  };

  config = lib.mkIf config.profiles.desktop-environment.bars.polybar.enable {
    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        i3Support = true;
        i3GapsSupport = true;
        alsaSupport = true;
        pulseSupport = true;
        iwSupport = true;
        githubSupport = true;
      };
      script = "polybar left & polybar right &";
      settings = {
        "bar/base" = {
          width = "100%";
          height = "24";
          modules-left = "i3";
          fixed-center = "true";

          # font-N = "<fontconfig pattern>;<vertical offset>";
          font-0 = "Hack Nerd Font:pixelsize=9;2";

          background = colors.primary.background;
          foreground = colors.primary.foreground;
          bottom = true;

          # wm-restack = "i3"; # for the tray
          separator = " | ";
        };
        "bar/left" = {
          "inherit" = "bar/base";
          monitor = "DVI-D-0";
          modules-right = "testmenu tailscale ethernet wifi volume ram date";

          # To render the tray right:
          tray-offset="30%";
          tray-position = "right";
        };
        "bar/right" = {
          "inherit" = "bar/base";
          modules-right = "temperature date";
          monitor = "HDMI-0";
        };
        "module/testmenu" = {
          type = "custom/menu";
          expand-right = false;
          label-open = "Apps";
          label-close = "x";
          label-separator = "|";

          menu-0-0 = "Browsers";
          menu-0-0-exec = "#testmenu.open.1";
          menu-0-1 = "Multimedia";
          menu-0-1-exec = "#testmenu.open.2";

          menu-1-0 = "Firefox";
          menu-1-0-exec = "firefox";
          menu-1-1 = "Chrome";
          menu-1-1-exec = "google-chrome-stable";

          menu-2-0 = "Gimp";
          menu-2-0-exec = "gimp";
          menu-2-1 = "Scrot";
          menu-2-1-exec = "scrot";
        };
        "module/network" = {
          type = "internal/network";
          ping-interval = 3;

          format-connected = "<label-connected>";
          label-connected = "%{F${colors.normal.cyan}}%essid%%{F-} %local_ip% %downspeed:8% %upspeed:8%";

          format-disconnected = "<label-disconnected>";
          format-disconnected-foreground = colors.bright.red;
          label-disconnected = "Disconnected";
        };
        "module/wifi" = {
          "inherit" = "module/network";
          interface = "wlp41s0";

          # All labels support the following tokens:
          #   %ifname%    [wireless+wired]
          #   %local_ip%  [wireless+wired]
          #   %local_ip6% [wireless+wired]
          #   %essid%     [wireless]
          #   %signal%    [wireless]
          #   %upspeed%   [wireless+wired]
          #   %downspeed% [wireless+wired]
          #   %linkspeed% [wired]
          label-connected = "%{F${colors.normal.cyan}}%essid%%{F-} %local_ip%";

          format-prefix-connected = " ";
          format-prefix-disconnected = "睊 ";
        };
        "module/ethernet" = {
          "inherit" = "module/network";
          interface = "enp39s0";
          ping-interval = 1;
          format-connected = "";
          format-disconnected = "";
        };
        "module/tailscale" = {
          "inherit" = "module/network";
          interface = "tailscale0";
          label-connected = "%{F${colors.normal.cyan}}Tailescale%{F-} %local_ip%";
          label-padding = 1;
        };
        "module/i3" = import ./i3.nix { inherit colors; };
        "module/date" = {
          type = "internal/date";
          interval = 1.0;
          date = "%Y-%m-%d";
          time = "%H:%M:%S";

          format = "<label>";
          # format-padding = 0;

          label = "%date% %time%";
        };
        "module/ram" = {
          type="internal/memory";
          interval = 3;
          format = "<label> <ramp-used>";
          format-prefix = " ";

          label = "%gb_used% %percentage_used%";

          # Only applies if <ramp-free> is used
          ramp-used-0 = "▁";
          ramp-used-0-foreground = colors.normal.green;
          ramp-used-1 = "▂";
          ramp-used-1-foreground = colors.bright.green;
          ramp-used-2 = "▃";
          ramp-used-2-foreground = colors.normal.blue;
          ramp-used-3 = "▄";
          ramp-used-3-foreground = colors.bright.blue;
          ramp-used-4 = "▅";
          ramp-used-4-foreground = colors.normal.yellow;
          ramp-used-5 = "▆";
          ramp-used-5-foreground = colors.bright.yellow;
          ramp-used-6 = "▇";
          ramp-used-6-foreground = colors.normal.red;
          ramp-used-7 = "█";
          ramp-used-7-foreground = colors.bright.red;
        };
        "module/volume" = {
          type = "internal/pulseaudio";
          master-mixer = "Master";
          mapping = "true";

          master-soundcard = "default";
          headphone-id = 9;

          format-volume = "<ramp-volume> <label-volume>";

          label-volume = "%percentage:3%%";
          label-volume-foreground = colors.primary.foreground;

          format-muted-prefix = "";
          format-muted-foreground = "#66";
          label-muted = "ﱝ";
          label-muted-foreground = colors.normal.white;

          ramp-volume-0 = "奄";
          ramp-volume-1 = "奔";
          ramp-volume-2 = "墳";
          ramp-volume-foreground = "#9f78e1";

          click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "module/temperature" = {
          "type" = "internal/temperature";
          thermal-zone = 0;
          warn-temperature = 60;

          format = "<ramp>  <label>";
          # format-underline = #f50a4d
          format-warn = "<ramp> <label-warn>";
          format-warn-foreground = "#a61f1f1f";

          label = "%temperature-c%";
          label-warn = "%temperature-c%";
          label-warn-foreground = "#F3F3BA";

          ramp-0 = "";
          ramp-1 = "";
          ramp-2 = "";
          ramp-foreground = "#F3F3BA";
        };
      };
    };
  };
}
