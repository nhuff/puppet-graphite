# Define: graphite::carbon::storage_aggregation
#
# Create a storage aggregation rule
#
# Parameters:
#   pattern     : metric pattern to match (required)
#   method      : Function to aggregate with (required)
#   xFilesFactor: Ratio of valid data points for aggregation (default: 0)
#   order       : Set order of aggregation rule in file (default:50)
#
# Example:
#
#   graphite::carbon::storage_aggregation{'sum_counts':
#     pattern      => '\.count$',
#     method       => 'sum',
#     xFilesFactor => '0.1',
#   }
#
define graphite::carbon::storage_aggregation (
  $pattern,
  $method,
  $xFilesFactor = 0,
  $order = 50,
  $conf_dir = $graphite::carbon::r_conf_dir
){
  concat::fragment {"graphite_agg_${title}":
    target  => "${conf_dir}/storage-aggregation.conf",
    order   => $order,
    content => template('graphite/storage-aggregation.erb'),
  }
}
