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

      # hostFiles = [
      #   # Blocks adware and malware websites
      #   (builtins.fetchurl {
      #     # 3.9.35
      #     url = "https://raw.githubusercontent.com/StevenBlack/hosts/666bf35e3c3b6bad91a0bb73de93a2ae960a663d/hosts";
      #     sha256 = "a6c865abcecd8ab5be414ff88acdc5f4e75db56a35096adcf860d0d8ce791fa7";
      #   })
      # ];
      stevenBlackHosts.enable = false;
    };

    services = {
      openssh.enable = true;
      tailscale.enable = true;
      rsyncd.enable = true;
    };
  };
}
