class graphite::carbon (
  $package       = 'UNSET',
  $conf_dir      = 'UNSET',
  $user          = 'UNSET',
  $storage_dir   = 'UNSET',
  $pid_dir       = 'UNSET',
  $log_dir       = 'UNSET',
  $graphite_root = 'UNSET'
) {
  include graphite::params
  include concat::setup

  $r_package = $package ? {
    'UNSET' => $graphite::params::carbon_package,
    default => $package
  }

  $r_graphite_root = $graphite_root ? {
    'UNSET' => $graphite::params::graphite_root,
    default => $graphite_root,
  }

  $r_conf_dir = $conf_dir ? {
    'UNSET' => "${r_graphite_root}/conf",
    default => $conf_dir
  }

  $r_storage_dir = $storage_dir ? {
    'UNSET' => "${r_graphite_root}/storage",
    default => $storage_dir
  }

  $r_log_dir = $log_dir ? {
    'UNSET' => "${r_storage_dir}/log/carbon",
    default => $log_dir,
  }

  $r_pid_dir = $pid_dir ? {
    'UNSET' => $r_storage_dir,
    default => $pid_dir,
  }

  $r_user = $user ? {
    'UNSET' => $graphite::params::carbon_user,
    default => $user
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
