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
  $index_file    = 'UNSET',
  $db_config     = 'UNSET',
  $graphite_root = 'UNSET'
) {
  include graphite::params

  $r_graphite_root = $graphite_root ? {
    'UNSET' => $graphite::params::graphite_root,
    default => $graphite_root
  }

  $r_package = $package ? {
    'UNSET' => $graphite::params::web_package,
    default => $package
  }

  $r_log_dir = $log_dir ? {
    'UNSET' => "${r_graphite_root}/storage/log/webapp",
    default => $log_dir
  }

  $r_user = $user ? {
    'UNSET' => $graphite::params::web_user,
    default => $user
  }

  $r_index_file = $index_file ? {
    'UNSET' => "${r_graphite_root}/storage/index",
    default => $index_file
  }

  #Can't have hash in selector so have to use case here
  case $db_config  {
    'UNSET' : { $r_db_config = {
        dbname   => "${r_graphite_root}/storage/graphite.db",
        engine   => 'django.db.backends.sqlite3',
        user     => '',
        password => '',
        host     => '',
        port     => ''
      }
    }
    default : {$r_db_config =  $db_config}
  }


  file {$r_log_dir:
    ensure  => 'directory',
    owner   => $r_user,
    mode    => '0644',
    require => Package['graphite-web'],
  }

  file{"${r_graphite_root}/webapp/graphite/local_settings.py":
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
