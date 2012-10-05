class graphite::carbon (
  $package     = 'UNSET',
  $conf_dir    = 'UNSET',
  $user        = 'UNSET',
  $storage_dir = 'UNSET',
  $pid_dir     = 'UNSET',
  $log_dir     = 'UNSET'
) {
  include graphite::params
  include concat::setup

  $r_package = $package ? {
    'UNSET' => $graphite::params::carbon_package,
    default => $package
  }

  $r_conf_dir = $conf_dir ? {
    'UNSET' => $graphite::params::carbon_conf_dir,
    default => $conf_dir
  }


  package{$r_package: ensure => 'installed'}

  concat{"${r_conf_dir}/carbon.conf":
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment{'carbon_header':
    target  => "${r_conf_dir}/carbon.conf",
    content => "#This file is managed by puppet\n",
    order   => '1'
  }
}
