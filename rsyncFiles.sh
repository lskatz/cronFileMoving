#!/bin/bash

set -e

# Set up the environment here including PATH if needed
NUMCPUS=4
VERSION=4
PATH=$PATH:$HOME/bin

source $(dirname $0)/lock.sh
# If the lock is in place, then exit
lock 342 || eexit "ERROR: already running an instance of $PROGNAME"

# rsync all files
logmsg "Beginning rsync at $(date)"
RSYNCXOPTS="-avr --stats --delete-excluded --chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r"
rsync $RSYNCXOPTS \
  /mnt/mount1/* \
  /mnt/mount2/

logmsg "END: $(date)"
