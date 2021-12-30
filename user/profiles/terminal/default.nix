{ config, lib, pkgs, ... }:
{
  options.profiles.terminal = {
    enable = lib.mkEnableOption "Terminal Applications";
  };

  config = lib.mkIf config.profiles.terminal.enable {
    home.packages = with pkgs; [ thefuck chroma ];

    programs.git = import ./git;
    programs.tmux = import ./tmux { inherit lib pkgs; };
    programs.vim = import ./vim { inherit lib pkgs; };
    programs.zsh = import ./zsh { inherit config lib pkgs; };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
