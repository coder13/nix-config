{ pkgs }:
let
    bc = "${pkgs.bc}/bin/bc";
    rofi = "${pkgs.rofi}/bin/rofi";
    xclip = "${pkgs.xclip}/bin/xclip";
in
''
    #!/usr/bin/env bash

    # https://github.com/onespaceman/menu-calc
    # Calculator for use with rofi/dmenu(2)
    # Copying to the clipboard requires xclip

    usage() {
        echo "    $(tput bold)menu calc$(tput sgr0)
        A calculator for use with Rofi or dmenu(2)
        Basic usage:
        = 4+2
        = (4+2)/(4+3)
        = 4^2
        = sqrt(4)
        = c(2)

        The answer can be used for further calculations

        The expression may need quotation marks if
        launched outside of Rofi/dmenu"
        exit
    }

    case $1 in
        -h|--help) usage ;;
    esac

    # calculate answer
    answer=$(echo "$@" | ${bc} -l | sed '/\./ s/\.\{0,1\}0\{1,\}$//')

    # present actions
    action=$(echo -e "Copy to clipboard\nClear\nClose" | ${rofi} -p "= $answer")

    # handle actions
    case $action in
        "Clear") $0 ;;
        "Copy to clipboard") echo -n "$answer" | ${xclip} ;;
        "Close") ;;
        "") ;;
        *) $0 "$answer $action" ;;
    esac
''