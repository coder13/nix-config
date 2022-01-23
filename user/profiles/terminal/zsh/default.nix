{ config, lib, pkgs, ... }:
{
  enable = true;
  shellAliases = {
    nix-update = "sudo nixos-rebuild switch --flake /home/caleb/.config/nix/";
    nix-dryrun = "nixos-rebuild dry-run --flake /home/caleb/.config/nix/";
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
    share = false;
  };
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "tmux" "thefuck" "node" "npm" "gem" "cp" "colorize" "fzf" "httpie" ];
    theme = "robbyrussell";
  };
  plugins = [
    {
      name = "zsh-nix-shell";
      file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.4.0";
        sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
      };
    }
  ];
  enableCompletion = true;
  enableAutosuggestions = true;
  initExtra = lib.readFile ./zshrc;
}
