define graphite::carbon::cache (
  $storage_dir = 'UNSET',
  $log_dir     = 'UNSET',
  $pid_dir     = 'UNSET',
  $user        = 'UNSET',
  $conf_dir    = 'UNSET'
) {
  $r_storage_dir = $storage_dir ? {
    'UNSET' => $graphite::params::carbon_storage_dir,
    default => $storage_dir
  }

  $r_pid_dir = $pid_dir ? {
    'UNSET' => $graphite::params::carbon_pid_dir,
    default => $pid_dir
  }

  $r_log_dir = $log_dir ? {
    'UNSET' => $graphite::params::carbon_log_dir,
    default => $log_dir
  }

  $r_user = $user ? {
    'UNSET' => $graphite::params::carbon_user,
    default => $user
  }

  $r_conf_dir = $conf_dir ? {
    'UNSET' => $graphite::carbon::r_conf_dir,
    default => $conf_dir
  }

  concat::fragment{"carbon_cache_${title}":
    target  => "${r_conf_dir}/carbon.conf",
    content => template('graphite/carbon_cache.erb'),
    order   => 50,
  }

  #Possible for multiple cache instances to share a schema file.
  if ! defined(Concat["${r_conf_dir}/storage-schemas.conf"]) {
    concat{"${r_conf_dir}/storage-schemas.conf":
      owner => $r_user,
      group => 0,
      mode  => '644',
    }
  }
}
