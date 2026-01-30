#!/bin/bash

network=/sys/class/net/wlp0s20f3
updown=$(cat "$network/operstate")
invstrength=$(iw dev wlp0s20f3 link | awk '/signal/ {print -$2}')
tethering=$(ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if ($i=="dev") print ($(i+1))}')

symbol() { 
    if [ $updown = "up" ]; then 
        if [ $invstrength -lt 50 ]; then 
            echo "󰤨"
        elif [ $invstrength -lt 60 ]; then 
            echo "󰤥"
        elif [ $invstrength -lt 70 ]; then 
            echo "󰤢"
        elif [ $invstrength -lt 80 ]; then 
            echo "󰤟"
        else
            echo "󰤯"
        fi
    else
        case "$tethering" in
            enp*)
            echo ""
            ;;
            *)
        
            echo "󰤮"
            ;;
        esac
    fi
}

name() {
    if [ $updown = "up" ]; then 
        nmcli | grep "^wlp" | sed 's/\ connected\ /Connected /g' | cut -d ':' -f2
    elif [ $updown = "down" ]; then 
        case "$tethering" in
            enp*)
            echo "Tethering"
            ;;
            *)
        
            echo "Disconnected"
            ;;
        esac
    fi
}

[ "$1" = "icon" ] && symbol && exit
[ "$1" = "name" ] && name && exit