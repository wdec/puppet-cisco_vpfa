# Parameters for puppet-cisco_vpfa
#
class cisco_vpfa::params {
  $vts_tls_version                    = 1.2
  $vts_network_config_method          = 'static'
  $vif_type                           = 'vhostuser'
  $package_ensure                     = 'present'
  $underlay_if_file                   = "/etc/vpe/vpfa/underlay_mac"
  $compute_hostname                   = $::fqdn
  $vpfa_hostname                      = $::hostname
  $network_nameserver                 = undef
  $bond_if_list                       = undef
  $underlay_ip_net_list               = undef
  $vtsr_ip_address_list               = []
  $username                           = ''
  $password_hash                      = ''
  $enabled                            = true
  $service_ensure                     = true
}
