{ config, home, lib, pkgs, ... }:
with lib;
let
  cfg = config.theme;

  yamlFormat = pkgs.formats.yaml { };

  themes = {
    solarized-light = import ./colorschemes/solarized-light.nix;
    solarized-dark = import ./colorschemes/solarized-dark.nix;
    hybrid = import ./colorschemes/hybrid.nix;
  };
in
with lib; {
  options.theme = {
    selectedTheme = mkOption {
      type = types.str;
      default = "solarized-light";
      description = "Specifies the theme to use";
    };

    font = mkOption {
      default = "Monospace";
      description = "Specifies the system font";
    };

    colors = mkOption {
      type = yamlFormat.type;
      default = themes.solarized-light;
      description = "The configured colorscheme for the system";
    };
  };

  config = {
    theme.colors = themes.${config.theme.selectedTheme};
  };
}
