#!/bin/bash
puppet apply --hiera_config=hiera.yaml --modulepath=modules --modulepath=vendor/modules manifests/site.pp
