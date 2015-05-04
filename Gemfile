source 'https://rubygems.org'

# Versions can be overridden with environment variables for matrix testing.
# Travis will remove Gemfile.lock before installing deps. As such, it is
# advisable to pin major versions in this Gemfile.

# Puppet core.
gem 'puppet', ENV['PUPPET_VERSION'] || '~> 3.6.0'
gem 'facter', ENV['FACTER_VERSION'] || '~> 2.2.0'
gem 'hiera'
gem 'deep_merge'

# Dependency management.
gem 'librarian-puppet'

# Testing utilities.
gem 'rake'
gem 'puppet-syntax'
gem 'puppet-lint'
gem 'rspec-puppet'
gem 'puppetlabs_spec_helper'
