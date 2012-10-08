class graphite::params {
  $graphite_root = '/opt/graphite'
  $whisper_package = 'whisper'
  $carbon_package = 'carbon'
  $carbon_conf_dir = "${graphite_root}/conf"
  $carbon_user = 'root'
  $carbon_storage_dir = "${graphite_root}/storage"
  $carbon_pid_dir = $carbon_storage_dir
  $carbon_log_dir = "${carbon_storage_dir}/log/carbon"
  $web_package = 'graphite-web'
  $web_log_dir = "${carbon_storage_dir}/log/webapp"
  $web_settings_file = "${graphite_root}/webapp/graphite/local_settings.py"
  $web_index_file = "${carbon_storage_dir}/index"
  $web_db_config = {
    dbname   => "${carbon_storage_dir}/graphite.db",
    engine   => 'django.db.backends.sqlite3',
    user     => '',
    password => '',
    host     => '',
    port     => ''
  }
  $web_user = $::osfamily ? {
    'RedHat' => 'apache', 
    'Debian' => 'www-data', 
    default  => 'root' 
  }

}
