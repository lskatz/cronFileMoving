# cronFileMoving
A sort of example repo for showing how to do automatic file copying safely

## introduction

The sort of general idea here is to make a system account that has cronjobs. Add these cronjobs using the `crontab -e` interface which I will not explain here.

There should be a couple of required directories to make in this system account: `$HOME/crontab` and `$HOME/log`, and then `$HOME/log/archive` and `$HOME/log/logrotate.d`.

Shell scripts go into the crontab folder. Log files are generated by these scripts and sent into the log directory.

All shell scripts _must_ source `lock.sh` and then have a few boilerplate lines so that they don't collide with each other.

    #!/bin/bash
    
    set -e
    source "$(dirname)/lock.sh"
    lock 123 || eexit "Already an instance of this script running, $0"

The example script is rsyncFiles.sh, and it has this boilerplate language in it plus a nifty rsync command.
