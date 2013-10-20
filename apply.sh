#!/bin/bash

# make sure modules are installed.
bundle exec librarian-puppet install

sudo puppet apply --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests/site.pp
