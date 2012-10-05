# = Class: graphite
#
# This module manages graphite
#
# == Sample Usage:
#
#   include graphite
#
# == Todo:
#
# * Implement user creation.
#
class graphite::params {
  $whisper_package = 'whisper'
  $carbon_package = 'carbon'
  $carbon_conf_dir = '/etc/carbon'
}

