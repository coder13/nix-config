{ pkgs, ... }:
let
  pamixer = "${pkgs.pamixer}/bin/pamixer";
in {
  services.cron = {
    enable = true;
    systemCronJobs = [
      # As all things are in nix, an absolute path is required for the commands.
      # Example:
      # ${pkgs.xyz}/bin/xyz ...

      # mutes the audio automatically at 4pm
      "*/1 16 * * * caleb sh -c \"${pamixer} -m >> /tmp/cron.log 2>&1\""
    ];
  };
}