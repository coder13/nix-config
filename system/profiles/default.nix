{ pkgs, ... }: {
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  users = {
    defaultUserShell = pkgs.zsh;
    groups.plugdev = {};
  };

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes ca-references";
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    pathsToLink = [ "/libexec" ]; # TODO: What is this?
    systemPackages = with pkgs; [
      # General Utils
      vim
      wget
      git

      # Audio Utils
      alsaUtils
      pavucontrol
      pamixer
    ];
    variables = {
      TERMINAL = "alacritty";     # TODO Remove?
      TERM = "screen-256color";   # TODO Remove?
    };
  };

  services = {
    # Bluetooth
    blueman.enable = true;

    # Audio
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # FIXME this still doesn't work but is included still
    # udev.packages = with pkgs; [
    #   ledger-udev-rules
    # ];

    # Databases
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    mongodb = {
      enable = true;
    };
    # redis.servers.enable = true; # FIXME this changed in a new version of nixos
  };

  security = {
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };

  # TODO Move elsewhere
  programs = {
    adb.enable = true;
    steam.enable = true;
    nm-applet.enable = true;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Hack" ];
    })
  ];

  imports = [
    ./display-server
    ./networking
  ];
}
