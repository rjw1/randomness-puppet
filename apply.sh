#!/bin/bash
puppet apply --hiera_config=hiera.yaml --modulepath=modules:vendor/modules manifests/site.pp
