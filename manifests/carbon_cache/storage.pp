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
define graphite::carbon_cache::storage ( $pattern,$retentions,$order=10){
  concat::fragment {$name:
    target  => $graphite::r_schema_file,
    order   => $order,
    content => template('graphite/storage-schemas.erb'),
    notify  => Service['carbon']
  }
}