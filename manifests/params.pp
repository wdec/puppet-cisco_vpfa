# Parameters for puppet-cisco_vpfa
#
class cisco_vpfa::params {
  $vts_tls_version = 1.2
  $vts_network_config_method = 'static'
  $vif_type = 'vhostuser'
  $package_ensure   = 'present'
}
