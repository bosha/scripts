#!/bin/bash
# -----------------------------------------------------------------------------
# showHideRun.sh
# -----------------------------------------------------------------------------
# Search window by class: if found - activate them, else - run
# -----------------------------------------------------------------------------
# Author: Bosha
# Website: http://the-bosha.ru
# -----------------------------------------------------------------------------

( ! which xdotool &>/dev/null || ! which wmctrl &>/dev/null ) \
    && echo "No xdotool or wmctrl found in system" && exit 1

CLASS="$1"
RUN="$2"

[[ -z "$CLASS" || -z "$RUN" ]] \
    && echo "Usage: "$0" [class-name] [command-to-run]" && exit 0

WINRAWID=`wmctrl -x -l | grep ${CLASS} | awk '{print $1}' | head -n 1`
WINID=$((${WINRAWID}))

if [ -z "${WINRAWID}" ]; then
    ${RUN}
else
    ACTIVEWIN=`xdotool getactivewindow`
    if [ "${ACTIVEWIN}" == "${WINID}" ]; then
        xdotool windowminimize ${WINID}
    else
        xdotool windowactivate ${WINID}
    fi
fi
