#!/bin/bash

( ! which zenity &>/dev/null || ! which wmctrl &>/dev/null ) \
    && echo "No zenity or wmctrl found in system. Stopping." && exit 1

run=`zenity --entry --title="Changing window title" -- text="New window title"`

[ -z "$run" ] && exit 1 || wmctrl -r :ACTIVE: -T "$run"
