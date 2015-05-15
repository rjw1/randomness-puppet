#!/bin/bash
# script to apply a puppet repo
set -e

# We need bundler installed for everything else to work.
# its deps are also everything else we need on Ubuntu 13.10 at least.
sudo apt-get update
sudo apt-get install bundler -y -qq

# We need ruby-dev and build-essential to build the json gem
sudo apt-get install ruby-dev -y -qq
sudo apt-get install build-essential -y -qq

# need to install git so that librarian-puppet can install modules via git.
sudo apt-get install git -y -qq

# make sure we have gems installed
bundle install --deployment

# make sure modules are installed.
bundle exec librarian-puppet install

# run rake tasks
bundle exec rake

# apply stuff
sudo bundle exec puppet apply $@ --verbose --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests
