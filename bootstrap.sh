#!/bin/bash
# script to bootstrap a machine
hostname=$1
#rsync the contents of randomness-puppet to a remote machine
echo "rsyncing to $hostname"
rsync -aqz --exclude-from=.rsync_exclude   ../randomness-puppet $hostname:
shift
# apply puppet
ssh $hostname "cd randomness-puppet; ./apply.sh $@"
