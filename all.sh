#!/bin/bash
# script to run puppet agasint all hosts
set -e

for host in `ls hieradata/node* | sed -e 's/^hieradata\/node\.//' -e 's/\.yaml$//'`
do
  echo $host $@
  ./bootstrap.sh $host $@
done
