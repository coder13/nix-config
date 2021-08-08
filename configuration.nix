# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./i3.nix
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.caleb = {
    isNormalUser = true;
    home = "/home/caleb";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  networking = {
    hostName = "grogu";

    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # networking.wireless.userControlled.enable = true;
    # networking.wireless.userControlled.group = "wheel";

    defaultGateway = "192.168.1.1";
    nameservers = [ "8.8.8.8" ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  useDHCP = false;
  interfaces = {
    enp39s0.useDHCP = true;
    wlp41s0.useDHCP = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #networking.wireless.networks = {
  #  "MyCharterWiFid7-5G" = {
  #    #psk="breezyquail345"
  #    pskRaw = "c63e0a99e670456907c25b1685aed89fa95743a6b42da5664136a6f3568750d0";
  #  };
  #};
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  environment.pathsToLink = [ "/libexec" ];

  services = {
    # xserver = {
    #   enable = true;

    #   desktopManager = {
    #     xterm.enable = false;
    #   };

    #   displayManager = {
    #     defaultSession = "none+i3";
    #   	sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ~/.Xmodmap; xset r rate 200 32";
    #   };

    #   windowManager.i3 = {
    #     enable = true;
    #     extraPackages = with pkgs; [
    #       dmenu #application launcher most people use
    #       i3status # gives you the default i3 status bar
    #       i3lock #default i3 screen locker
    #       i3blocks #if you are planning on using i3blocks over i3status
    #     ];
    #   };
    # };
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
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      (writeShellScriptBin "nixFlakes" ''
        exec ${nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
      '')
    ];
    variables = {
      TERMINAL = "alacritty";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

