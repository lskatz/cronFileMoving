#!/bin/bash

#make a lock so that this only runs one at a time
function lock() {
    readonly LOCK_FD=$1
    readonly PROGNAME=$(basename "$0")
    readonly LOCKFILE_DIR=/tmp
    readonly LOCKFILE="$LOCKFILE_DIR/$PROGNAME.lock"

    local fd=${2:-$LOCK_FD}

    # create lock file
    eval "exec $fd>$LOCKFILE"

    # acquier the lock
    flock -n $fd \
        && return 0 \
        || return 1
}

# Exit with an error message
eexit() {
  local error_str="$@"

  echo $error_str
  exit 1
}

function logmsg() {
  scriptName=$(basename $0)
  echo "$scriptName: $@" >& 2
}
