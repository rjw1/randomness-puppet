#!/bin/bash
# script to bootstrap a machine such that puppet can be applied.

#rsync the contents of randomness-puppet to a remote machine
rsync -avzPh --stats --exclude-from=.rsync_exclude   ../randomness-puppet root@$1:
