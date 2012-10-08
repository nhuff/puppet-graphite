# = Class: graphite
#
# This module manages graphite
#
# == Parameters
#  local_settings_file: path to the graphite web local_settings.py file
#  schema_file: path to the storage-schemas.conf file
#  time_zone: time zone to set in local_settings.py file
# == Sample Usage:
#
#   include graphite
#
# == Todo:
class graphite(
  $user          = 'UNSET',
  $graphite_root = 'UNSET'
){
  include graphite::params
  include graphite::whisper

  anchor{'graphite::start':}
  anchor{'graphite:end':}

  $r_graphite_root = $graphite_root ? {
    'UNSET' => $graphite::params::graphite_root,
    default => $graphite_root
  }

  class{'graphite::carbon':
    user          => $user,
    graphite_root => $r_graphite_root,
  }
  class{'graphite::web':
    user          => $user,
    graphite_root => $r_graphite_root,
  }

  Anchor['graphite::start']  -> Class['graphite::whisper']
  Class['graphite::whisper'] -> Class['graphite::carbon']
  Class['graphite::carbon']  -> Class['graphite::web']
  Class['graphite::web']     -> Anchor['graphite::end']

  carbon::cache{'a':}
}

