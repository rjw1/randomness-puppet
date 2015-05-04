#!/bin/bash
# script to bootstrap a machine
hostname=$1
#rsync the contents of randomness-puppet to a remote machine
rsync -avzPh --stats --exclude-from=.rsync_exclude   ../randomness-puppet $hostname:
shift
# apply puppet
ssh $hostname "cd randomness-puppet; ./apply.sh $@"
