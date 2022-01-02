{ pkgs, locker, ... }:
let
  lock = "$${locker}/bin/lock";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in
  pkgs.writeShellScript "i3exit" ''
  case "$1" in
    lock)
      ${lock}
      ;;
    logout)
      ${pkgs.i3-gaps}/bin/i3-msg exit
      ;;
    switch_user)
      dm-tool switch-to-greeter
      ;;
    suspend)
      ${lock} && ${systemctl} suspend
      ;;
    hibernate)
      ${lock} && ${systemctl} hibernate
      ;;
    reboot)
      ${systemctl} reboot
      ;;
    shutdown)
      ${systemctl} poweroff
      ;;
    *)
      echo "== ! i3exit: missing or invalid argument ! =="
      echo "Usage: $0 { lock | logout | switch_user | suspend | hibernate | reboot | shutdown }"
      exit 2
  esac

  exit 0
  ''