class graphite::carbon_cache::service {
  service { 'carbon':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['carbon'],
  }


}


