# = Class: graphite::whisper
#
# Description of graphite::whisper
#
# == Actions:
#
# Installs the whisper package.
#
class graphite::whisper (
  $package = 'UNSET'
) {
  include graphite::params
  $r_package = $package ? {
    'UNSET' => $graphite::params::whisper_package,
    default => $package
  }

  package {$r_package:
    ensure => present;
  }

}

