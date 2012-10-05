# = Class: graphite::web
#
# Installs the graphite webfontend.
#
# == Actions:
#
# Installs packages for graphite web frontend.
#
# == Requires:
#
# Running web server.
#
# == Todo:
#
# * Update documentation
#
class graphite::web (
  $package = 'UNSET'
) {
  include graphite::params

  $r_package = $package ? {
    'UNSET' => $graphite::params::web_package,
    default => $package
  }
  package { 'graphite-web': ensure => present }
}



