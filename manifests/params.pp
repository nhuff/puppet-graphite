class graphite::params {
  $graphite_root = '/opt/graphite'
  $whisper_package = 'whisper'
  $carbon_package = 'carbon'
  $carbon_user = 'root'
  $web_package = 'graphite-web'
  $web_user = $::osfamily ? {
    'RedHat' => 'apache',
    'Debian' => 'www-data',
    default  => 'root'
  }
}
