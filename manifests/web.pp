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
  $package       = 'UNSET',
  $user          = 'UNSET',
  $log_dir       = 'UNSET',
  $settings_file = 'UNSET',
  $index_file    = 'UNSET',
  $db_config     = 'UNSET',
  $graphite_root = 'UNSET'
) {
  include graphite::params

  $r_package = $package ? {
    'UNSET' => $graphite::params::web_package,
    default => $package
  }

  $r_log_dir = $log_dir ? {
    'UNSET' => $graphite::params::web_log_dir,
    default => $log_dir
  }

  $r_user = $user ? {
    'UNSET' => $graphite::params::web_user,
    default => $user
  }

  $r_settings_file = $settings_file ? {
    'UNSET' => $graphite::params::web_settings_file,
    default => $settings_file
  }

  $r_index_file = $index_file ? {
    'UNSET' => $graphite::params::web_index_file,
    default => $index_file
  }

  $r_db_config = $db_config ? {
    'UNSET' => $graphite::params::web_db_config,
    default => $db_config
  }

  $r_graphite_root = $graphite_root ? {
    'UNSET' => $graphite::params::graphite_root,
    default => $graphite_root
  }

  file {$r_log_dir:
    ensure  => 'directory',
    owner   => $r_user,
    mode    => '0644',
    require => Package['graphite-web'],
  }

  file{$r_settings_file:
    ensure  => 'file',
    content => template('graphite/local_settings.py.erb','graphite/web_db.erb'),
    mode    => '0644',
    require => Package['graphite-web'],
  }

  file{$r_index_file:
    ensure  => 'file',
    owner   => $r_user,
    mode    => '0644',
    require => Package['graphite-web'],
  }

  file{"${r_graphite_root}/conf/graphite.wsgi":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "${r_graphite_root}/conf/graphite.wsgi.example",
    require => Package['graphite-web']
  }

  if $r_db_config['engine'] == 'django.db.backends.sqlite3' {

    $db_dir = regsubst($r_db_config['dbname'],'^(/.*)/.*$','\1')

    exec{'create_graphite_db':
      command => '/usr/bin/python manage.py syncdb --noinput',
      cwd     => "${r_graphite_root}/webapp/graphite",
      creates => $r_db_config['dbname'],
      require => Package['graphite-web'],
    }

    file{$r_db_config['dbname']:
      owner   => $r_user,
      require => Exec['create_graphite_db'],
    }

    file{$db_dir:
      ensure  => 'directory',
      owner   => $r_user,
      mode    => '0755',
      require => Package['graphite-web'],
    }
  }

  package { 'graphite-web': ensure => present }
}



