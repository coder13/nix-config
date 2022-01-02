{
  enable = true;
  blur = true;
  inactiveDim = "0.3";

  fade = true;
  fadeDelta = 5;

  opacityRule = [
    "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
    "94:class_g = 'Alacritty'"
    "94:class_g = 'Blueman-manager'"
    "94:class_g = 'discord'"
    "94:class_g = 'Zathura'"
  ];

  vSync = false;

  shadow = true;
  shadowExclude = [
    "window_type *= 'menu'"
    "name ~= 'Firefox\$'"
    "focused = 1"
  ];
  shadowOffsets = [ (-20) (-20) ];
  experimentalBackends = true;
};