#!/bin/bash

( ! which exiftool &>/dev/null ) \
    && echo "No exiftool found in your system!" && exit 1;

main() {
    for param in "$@"; do
        [[ -z "$param" ]] && continue
        [[ ! -e "$param" ]] \
            && echo "No such file or directory: [ "$param" ]. Skipping" && continue

        [[ -f "$param" ]] \
            && exiftool -P -filename=%f_CLEAN.%e -gps:all= "$param"

        [[ -d "$param" ]] \
            && exiftool -r -P -filename=%f_CLEAN.%e -gps:all= "$param"
    done
}

[[ "$#" -eq 0 ]] && (echo "Usage: "$0" [list of file or directories]" && exit 1) || main $@
