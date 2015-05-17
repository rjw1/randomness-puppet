#!/bin/bash
# script to apply a puppet repo
set -e

# We need bundler installed for everything else to work.
# its deps are also everything else we need on Ubuntu 13.10 at least.
echo "updating apt"
sudo apt-get update -qq
echo "installing needed packages"
sudo apt-get install bundler -y -qq

# We need ruby-dev and build-essential to build the json gem
sudo apt-get install ruby-dev -y -qq
sudo apt-get install build-essential -y -qq

# need to install git so that librarian-puppet can install modules via git.
sudo apt-get install git -y -qq

# make sure we have gems installed
echo "bundle installing gems"
bundle install --deployment --quiet

# make sure modules are installed.
echo "installing puppet modules"
bundle exec librarian-puppet install --quiet

# run rake tasks
echo "running puppet tests"
bundle exec rake

# apply stuff
echo "running puppet"
sudo bundle exec puppet apply $@ --verbose --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests
