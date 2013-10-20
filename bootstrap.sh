#!/bin/bash
# script to bootstrap a machine

#rsync the contents of randomness-puppet to a remote machine
rsync -avzPh --stats --exclude-from=.rsync_exclude   ../randomness-puppet root@$1:

# apply puppet
ssh root@$1 "cd randomness-puppet; ./apply.sh"
