#!/bin/bash

_rofi() {
  rofi -dmenu "$@"
}

get_monitors() {
  xrandr --listmonitors | tail +2
}

rofi_prompt() {
    local mesg="$1" entries="$2" prompt="$3"
    printf "$(printf "$entries" | _rofi -mesg "$mesg" -p "$prompt")"
    # [[ -n $mesg ]] && printf "$(printf "$entries" | _rofi -mesg "$mesg" -p "$prompt")"
    # [[ -z $mesg ]] && printf "$(printf "$entries" | _rofi -p "$prompt")"
}

prompt_monitor() {
  local monitor menu msg

  while true
  do
    menu="Brightness\nRotation\nPosition\nMake Primary\n"
    monitor="$(echo $1 | cut -d ' ' -f 4)"
    option="$(rofi_prompt "$1 | $msg" "$menu" "Option")"
    
    [[ -z $option ]] && break

    echo "Changing $option for monitor"

    case $option in
      "Brightness")
        prompt_brightness $monitor
        ;;
      "Rotation")
        prompt_rotation $monitor
        ;;
      "Position")
        msg=$(prompt_position $monitor)
        ;;
      *) break;;
    esac
  done
  main
}

prompt_brightness() {
  local monitor=$1 brightness
  brightness="$(rofi_prompt "Set Brightness" "" "Brightness")"
  [[ -z $brightness ]] && return
  echo "setting brightness for $monitor to $brightness"
  xrandr --output $monitor --brightness $brightness
}

prompt_rotation() {
  local monitor=$1 rotation menu
  menu="normal\ninverted\nleft\nright"
  rotation="$(rofi_prompt "Set Rotation" "$menu" "Rotation")"
  [[ -z $rotation ]] && return
  echo "setting rotation for $monitor to $rotation"
  xrandr --output $monitor --rotation $rotation
}

prompt_position() {
  local monitor=$1 position menu
  monitors="$(get_monitors | grep -v $monitor)"
  [[ -z $monitors ]] && echo "Not enough monitors to set a position." && return

  menu="left of\nright of\nabove\nbelow"
  position="$(rofi_prompt "Set Position" "$menu" "Position")"
  echo foo
  [[ -z $position ]] && return

  echo "querying monitor"

  monitor2="$(rofi_prompt "Choose Monitor" "$monitors" "Monitor")"
  [[ -z $monitor2 ]] && return

  echo "setting position for $monitor to $position"

  case $position in
    "left of")
      xrandr --output $monitor --left-of $monitor2
    ;;
    "right of")
      xrandr --output $monitor --right-of $monitor2
    ;;
    "above")
      xrandr --output $monitor --above $monitor2
    ;;
    "below")
      xrandr --output $monitor --below $monitor2
    ;;
  esac
}

main() {
  local menu option
  menu="$(get_monitors)\n"
  # print rofi menu and cut input
  option="$(rofi_prompt "" "$menu" "Monitor")"
  [[ -z $option ]] && exit 0
  echo "$option selected"

  prompt_monitor "$option"
} && main
