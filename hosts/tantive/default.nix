# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
    ];

  nixpkgs.overlays = [
    (import ../../modules/ledger)
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.useOSProber = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes ca-references";
  };

  users.groups.plugdev = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.caleb = {
    isNormalUser = true;
    home = "/home/caleb";
    extraGroups = [ "wheel" "plugdev" ];
  };

  networking = {
    hostName = "tantive";

    networkmanager.enable = true;

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp39s0.useDHCP = true;
      wlp41s0.useDHCP = true;
      tailscale0.useDHCP = true;
    };

    firewall = {
      enable = false;
      allowedUDPPorts = [ 41641 ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.pathsToLink = [ "/libexec" ];

  security.rtkit.enable = true;
  services = {
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      displayManager.sessionCommands = ''
        ${pkgs.xorg.xmodmap}/bin/xmodmap ~/.Xmodmap
        ${pkgs.xorg.xset} r rate 200 32
      '';
    };
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    # Enable the OpenSSH daemon.
    openssh.enable = true;
    udev.packages = with pkgs; [
      ledger-udev-rules
    ];
    mongodb.enable = true;
    redis.enable = true;
    tailscale.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      # general utils
      vim
      wget
      git

      # audio
      alsaUtils
      pavucontrol
      pulseaudio
      pamixer
      helvum # GTK-based patchbay for pipewire

      # vpn
      tailscale
    ];
    variables = {
      TERMINAL = "alacritty";
      TERM = "xterm-256color";
    };
  };

  programs.steam.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

