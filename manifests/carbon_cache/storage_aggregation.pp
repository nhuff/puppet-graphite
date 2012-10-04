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
define graphite::carbon_cache::storage_aggregation (
  $pattern,
  $method,
  $xFilesFactor = 0,
  $order = 50)
{
  $conf = $graphite::storage_aggregation_file

  concat::fragment {"graphite_agg_${title}":
    target  => $conf,
    order   => $order,
    content => template('graphite/storage-aggregation.erb'),
  }
}
