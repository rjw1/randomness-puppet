#!/bin/bash
set -e

# make sure modules are installed.
bundle exec librarian-puppet install

# run rake tasks
bundle exec rake

sudo puppet apply --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests/site.pp
