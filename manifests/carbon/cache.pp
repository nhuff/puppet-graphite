define graphite::carbon::cache (
  $storage_dir = 'UNSET',
  $log_dir     = 'UNSET',
  $pid_dir     = 'UNSET',
  $user        = 'UNSET',
  $conf_dir    = 'UNSET'
) {
  $r_storage_dir = $storage_dir ? {
    'UNSET' => $graphite::carbon::r_storage_dir,
    default => $storage_dir
  }

  $r_pid_dir = $pid_dir ? {
    'UNSET' => $graphite::carbon::r_pid_dir,
    default => $pid_dir
  }

  $r_log_dir = $log_dir ? {
    'UNSET' => $graphite::carbon::r_log_dir,
    default => $log_dir
  }

  $r_user = $user ? {
    'UNSET' => $graphite::carbon::r_user,
    default => $user
  }

  $r_conf_dir = $conf_dir ? {
    'UNSET' => $graphite::carbon::r_conf_dir,
    default => $conf_dir
  }
  
  file{"${r_storage_dir}/whisper":
    ensure => 'directory',
    owner  => $r_user,
    mode   => '0644',
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
    concat::fragment{"schema_header_${title}":
      target  => "${r_conf_dir}/storage-schemas.conf",
      content => "#This file managed by puppet\n",
      order   => 01
    }
  }

  service{"carbon-cache-${title}":
    provider => 'base',
    ensure   => true,
    start    => "${graphite::carbon::r_graphite_root}/bin/carbon-cache.py --instance=${title} start",
    stop     => "${graphite::carbon::r_graphite_root}/bin/carbon-cache.py --instance=${title} stop",
    status   => "${graphite::carbon::r_graphite_root}/bin/carbon-cache.py --instance=${title} status",
  }
}
