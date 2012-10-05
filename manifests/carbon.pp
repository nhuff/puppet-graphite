class graphite::carbon (
  $package  = 'UNSET',
  $conf_dir = 'UNSET'
) {
  include graphite::params
  include concat::setup

  $r_package = $package ? {
    'UNSET' => $graphite::params::carbon_package,
    default => $package
  }

  $r_confdir = $conf_dir ? {
    'UNSET' => $graphite::params::carbon_conf_dir,
    default => $conf_dir
  }

  package{$r_package: ensure => 'installed'}

  concat{"${r_confdir}/carbon.conf":
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment{'carbon header':
    target  => "${r_confdir}/carbon.conf",
    content => "#This file managed by puppet\n",
  }
}
