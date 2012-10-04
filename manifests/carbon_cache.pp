# = Class: graphite::carbon_cache
#
# Install carbon and enable carbon.
#
# == Actions:
#
# Installs the carbon package and enables the carbon service.
#
# == Todo:
#
# * Update documentation
#
class graphite::carbon_cache {
  include graphite::carbon_cache::package
  include graphite::carbon_cache::config
  include graphite::carbon_cache::service
}

