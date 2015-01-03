#!/bin/bash
# -----------------------------------------------------------------------------
# autoLoginToSwitch.sh
# -----------------------------------------------------------------------------
# Script for auto-login for some
# routers/switches (Cisco, D-Link for example)
#
# Use --help key to see how to use it.
#
# -----------------------------------------------------------------------------
# Author: Bosha
# Website: http://the-bosha.ru
# -----------------------------------------------------------------------------

default_terminal="xfce4-terminal"

have () {
    (which "$1" &> /dev/null) \
        && return 0 || return 1
}

notify () {
    [[ -z "$osdnotify" ]] && echo "$1" || notify_send "$1"
}

notify_send () {
    if (have "notify-send") ; then
        notify-send "Telnet" "$1" \
            -u normal \
            -i gtk-dialog-warning \
            -t 8000
    else
        echo "$1"
    fi
}

die() {
    notify "$1"
    [[ -z "$2" ]] && exit 1 || exit "$2"
}

usage() {
cat << EOF
usage: "$0" -u USER -p PASS [OPTIONS]

Simple script for managing nginx virtual hosts.

OPTIONS:
-h, --help            Show this help
-u, --username        User name
-p, --password        User password
-i, --ip              IP-Address/hostname to connect to
-t, --terminal        Determine terminal (xfce4-terminal/gnome-termina/etc..)
-o, --osdnotify       Determine use or not notify-osd for notifications
EOF
}

spawn_telnet () {
    local term="$1"
    local host="$2"
    local user="$3"
    local pass="$4"

    declare -r commands="
    # This should be enough for some devices
    spawn telnet $host
    expect {
        \"?ser?ame\" {
            send $user\n
            expect \"?ass?ord: \"
            send $pass\n
        }
    }
    interact
    "

    $($term --geometry 120x30+30+20 \
            --title "Telnet to "$host"" \
            --execute expect -c "$commands"
    )
}

main() {

    ( ! have "expect") && die "No expect found in system"

    [[ -z "$username" ]] || [[ -z "$password" ]] \
        && die "Username/password not specified"

    ( ! ping -c1 -i1 -n -s10 -W1 "$hostname"  &>/dev/null ) \
        && die ""$hostname" not available"

    if [[ -z "$terminal" ]]; then
        if ( ! have "$default_terminal" ); then
            die "Could not find default terminal, no terminal specified also"
        else
            spawn_telnet "$default_terminal" "$hostname" "$username" "$password"
        fi
    else
        spawn_telnet "$terminal" "$hostname" "$username" "$password"
    fi

}

PARSEDOPTS=$(getopt -n "$0"  \
    -o h,u:,p:,i:,t:,o \
    --long "help,username:,password:,ip:,terminal:,osdnotify"  \
    -- "$@"
)

eval set -- "$PARSEDOPTS"

while true;
do
    case "$1" in
        -h|--help)
            usage
            exit 0
            shift;;
        -u|--username)
            declare -r username="$2"
            shift 2;;
        -p|--password)
            declare -r password="$2"
            shift 2;;
        -i|--ip)
            declare -r hostname="$2"
            shift 2;;
        -t|--terminal)
            terminal="$2"
            shift 2;;
        -o|--osdnotify)
            osdnotify=true
            shift;;
        --)
            shift
            break;;
    esac
done

main
