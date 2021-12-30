{ config, lib, pkgs, ... }:
let
  cfg = config.profiles.networking;
in
{
  options.profiles.networking = {
    enable = lib.mkEnableOption "Networking";
  };

  config = lib.mkIf cfg.enable {
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

      interfaces = {
        tailscale0.useDHCP = true;
      };
    };

    services = {
      openssh.enable = true;
      tailscale.enable = true;
      rsyncd.enable = true;
    };
  };
}
