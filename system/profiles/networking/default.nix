{ config, lib, pkgs, ... }:

{
  options.profiles.networking = {
    enable = lib.mkEnableOption "Networking";
  };

  config = lib.mkIf config.profiles.networking.enable {
    networking = {
      # The global useDHCP flag is deprecated, therefore explicitly set to false here.
      # Per-interface useDHCP will be mandatory in the future, so this generated config
      # replicates the default behaviour.
      useDHCP = false;

      networkmanager.enable = true;

      # TODO update and finalize
      firewall = {
        enable = false;
        allowedUDPPorts = [ 41641 ];
      };
    };

    services = {
      openssh.enable = true;
      tailscale.enable = true;
      rsyncd.enable = true;
    };
  };
}
