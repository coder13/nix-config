{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    caleb = {
      shell = pkgs.zsh;
      isNormalUser = true;
      home = "/home/caleb";
      extraGroups = [ "wheel" "plugdev" "docker" "adbusers" "wireshark"];
    };

    root = {
      shell = pkgs.zsh;
    };
  };

  home-manager.users = {
    caleb = {
      profiles = {
        desktop-environment.enable = true;
        # terminal.enable = true;
        graphical.enable = true;
      };

      theme = {
        selectedTheme = "hybrid";
        font = "Hack";
      };
    };

    root = {
      # profiles.terminal.enable = true; TODO Implement
    };
  };
}