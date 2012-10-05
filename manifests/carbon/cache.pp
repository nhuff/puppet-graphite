define graphite::carbon::cache (
  $storage_dir = $graphite::carbon::r_storage_dir,
  $log_dir = $graphite::carbon::r_log_dir,
  $pid_dir = $graphite::carbon::r_pid_dir,
  $user = $graphite::carbon::r_user,
  $conf_dir = $graphite::carbon::r_conf_dir
) {
  concat::fragment{"carbon_cache_${title}":
    target  => "${conf_dir}/carbon.conf",
    content => template('graphite/carbon_cache.erb')
  }
}
