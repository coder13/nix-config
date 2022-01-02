{ pkgs }:
let
  alacritty = "${pkgs.alacritty}/bin/alacritty";
  rofi = "${pkgs.rofi}/bin/rofi";
  zsh = "${pkgs.zsh}/bin/zsh";
  tmux = "${pkgs.tmux}/bin/tmux";
in
  pkgs.writeScriptBin "rofi-tmux" ''
    #!/usr/bin/env bash
    set -e
    cd $HOME

    declare -r TERMINAL="${alacritty} -e"

    _rofi() {
      ${rofi} -dmenu "$@"
    }

    rofi_menu() {
      local mesg="$1" entries="$2" prompt="$3"
      printf "$(printf "$entries" | _rofi -mesg "$mesg" -p "$prompt")"
    }

    session-list() {
      local sessions="${tmux} list-sessions"
      while read session; do
        printf "[#] $session\n"
      done < <($sessions | sort -n)
    }

    create() {
      $TERMINAL ${tmux} new-session
    }

    attach() {
      local session=$1
      echo $session
      $TERMINAL ${tmux} a -t "$session"
    }

    main() {
      local menu option session attach create
      menu="[+] Create new session\n"
      menu+="$(session-list)\n"
      option=$(rofi_menu "select tmux session" "$menu" "tmux: ")
      [[ -z "$option" ]] && exit 1

      session="$(printf "$option" | grep -e '^\[#\] \(.*\):.*$' | sed -e 's/^\[#\] \(.*\): [1-9] windows.*$/\1/g')"
      [[ -n "$session" ]] && attach=true || attach=false
      [[ -n "$(printf "$option" | grep -e '\[+\]')" ]] && create=true || create=false

      echo "create" $create
      echo "attach" $attach
      $create && create && exit 0
      $attach && attach "$session" && exit 0
    } && main
''