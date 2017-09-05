# == Class: cisco_vpfa::config
#
# This class is used to manage arbitrary cisco_vpfa configurations.
#
# === Parameters
#
# [*cisco_vpfa_config*]
#   (optional) Allow configuration of arbitrary cisco_vpfa configurations.
#   The value is an hash of cisco_vpfa_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   cisco_vpfa_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class cisco_vpfa::config {

  if $cisco_vpfa::underlay_interface =~ /^bond/ {
    cisco_vpfa_config {
      'other/bond_if_list': value => $cisco_vpfa::bond_if_list;
    }
  }

  cisco_vpfa_config {
    'vts/vts_address': value => $cisco_vpfa::vts_address;
    'vts/vts_registration_api': value => $cisco_vpfa::vts_registration_api;
    'vts/vts_username': value => $cisco_vpfa::vts_username;
    'vts/vts_password': value => $cisco_vpfa::vts_password;
    'network/hostname': value => $cisco_vpfa::vpfa_hostname;
    'network/network_config_method': value => $cisco_vpfa::network_config_method;
    'network/network_ip_address': value => $cisco_vpfa::network_ipv4_address;
    'network/network_ip_netmask': value => $cisco_vpfa::network_ipv4_mask;
    'network/network_ip_gateway': value => $cisco_vpfa::network_ipv4_gateway;
    'other/compute_host_name': value => $cisco_vpfa::compute_hostname;
    'other/network_nameserver': value => $cisco_vpfa::network_nameserver;
    'other/vif_type': value => $cisco_vpfa::params::vif_type;
    'other/underlay_if_name': value => $cisco_vpfa::underlay_interface;
    'other/underlay_ip_net_list': value => $cisco_vpfa::underlay_ip_net_list;
    'other/tls_version': value => 1.2;
  }
}
#class cisco_vpfa::config (
#  $cisco_vpfa_config = {},
#) {
#
#  include ::cisco_vpfa::deps
#
#  validate_hash($cisco_vpfa_config)
#
#  create_resources('cisco_vpfa_config', $cisco_vpfa_config)
#}
