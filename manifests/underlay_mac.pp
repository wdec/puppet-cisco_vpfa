# == Class ciscp_vpfa::underlay_mac
#
# Prepare the underlay MAC address file for VPFA.
#
class cisco_vpfa::underlay_mac {
  #  $lead_interface = $cisco_vpfa::underlay_interface
  #  $mac = $::macaddress

  file {"/etc/vpe/vpfa/underlay_mac" :
    ensure => present,
    content => $::macaddress,
  }
}