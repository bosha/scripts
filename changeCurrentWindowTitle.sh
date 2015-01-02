#!/bin/bash
# -----------------------------------------------------------------------------
# changeCurrentWindowTitle.sh
# -----------------------------------------------------------------------------
# Change current (active) window title using zenity dialog for new title
# -----------------------------------------------------------------------------
# Author: Bosha
# Website: http://the-bosha.ru
# -----------------------------------------------------------------------------

( ! which zenity &>/dev/null || ! which wmctrl &>/dev/null ) \
    && echo "No zenity or wmctrl found in system. Stopping." && exit 1

run=`zenity --entry --title="Changing window title" -- text="New window title"`

[ -z "$run" ] && exit 1 || wmctrl -r :ACTIVE: -T "$run"
