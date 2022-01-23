{ pkgs, ... }:
let
  scrot = "${pkgs.scrot}/bin/scrot";
  mogrify = "${pkgs.imagemagick}/bin/mogrify";
  i3lock = "${pkgs.i3lock}/bin/i3lock";
  xset = "${pkgs.xorg.xset}/bin/xset";
  lockScreenFile = "/tmp/screen_locked.png";
in
  pkgs.writeShellScript "lock" ''
    # Take a screenshot
    DISPLAY=:0 ${scrot} ${lockScreenFile}

    # Pixellate it 10x
    ${mogrify} -scale 10% -scale 1000% ${lockScreenFile}

    # Lock screen displaying this image.
    DISPLAY=:0 ${i3lock} -i ${lockScreenFile}

    # Turn the screen off after a delay.
    sleep 60; pkill i3lock && ${xset} dpms force off
  ''
