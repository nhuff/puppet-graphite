# Define: graphite::carbon::storage
#
# Add a storage schema entry to carbon
#
# Parameters:
#   pattern   : Metric pattern to match (required)
#   retentions: Retention rules for the metric as a string (required)
#   order     : Order the rules appear in the schema file (default=10)
#
# Example:
#
#   graphite::carbon::storage{'default_1min_for_1day':
#     pattern    => '.*',
#     retentions => '60s:1d',
#   }
#
define graphite::carbon::storage (
  $pattern,
  $retentions,
  $conf_dir=$graphite::carbon::r_conf_dir,
  $order=10
){
  concat::fragment {"carbon_storage_${name}":
    target  => "${conf_dir}/storage-schemas.conf",
    order   => $order,
    content => template('graphite/storage-schemas.erb'),
    notify  => Service['carbon']
  }
}
