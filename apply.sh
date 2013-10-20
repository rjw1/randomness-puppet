#!/bin/bash
# script to apply a puppet repo
set -e

# We need bundler installed for everything else to work.
# its deps are also everything else we need.
apt-get install bundler -y -qq

# make sure we have gems installed
bundle install --deployment

# make sure modules are installed.
bundle exec librarian-puppet install

# run rake tasks
bundle exec rake

# apply stuff
sudo bundle exec puppet apply --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests/site.pp
