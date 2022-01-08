# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
    ./users.nix
  ];

  profiles = {
    display-server.enable = true;
    networking.enable = true;
  };

  # FIXME ledger mess needs fixing
  # nixpkgs.overlays = [
  #  (import ../../modules/ledger)
  #];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    grub.useOSProber = true;
  };

  # There is currently a bug in the nixos code and I may be missing a systems/ profile directory
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.device = "nodev";

  networking = {
    hostName = "grogu";

    interfaces = {
      enp39s0.useDHCP = true;
      wlp41s0.useDHCP = true;
    };
  };

  services.xserver = {
    windowManager.i3.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    openrazer = {
      enable = true;
      keyStatistics = true;
    };
  };

  virtualisation.docker.enable = true;
}
