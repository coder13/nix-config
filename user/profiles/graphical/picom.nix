{
  enable = false;
  blur = false;
  inactiveDim = "0.00";

  # Fade rules:
  fade = false;
  fadeDelta = 0;
  fadeSteps = [ "1" "1" ];
  # End Fade Rules

  opacityRule = [
    "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    "94:class_g = 'Alacritty'"
    "94:class_g = 'Blueman-manager'"
    "94:class_g = 'discord'"
    "94:class_g = 'Zathura'"
  ];

  vSync = true;

  shadow = false;
  shadowExclude = [
    "window_type *= 'menu'"
    "name ~= 'Firefox\$'"
    "focused = 1"
  ];
  shadowOffsets = [ (0) (-5) ];
  shadowOpacity = "0.2";
  experimentalBackends = true;

  extraOptions = ''
  mark-ovredir-focused = true
  '';
}