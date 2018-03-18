# == Class ciscp_vpfa::underlay_mac
#
# Prepare the underlay MAC address file for VPFA.
#
#NOTE: This class is a future placeholder. Currently when puppet runs the lead VPP interface is already mapped into VPP
#The logic for the underlay_mac deriviation is in the heat vpfa_extras script
#
class cisco_vpfa::underlay_mac {
  #  $lead_interface = $cisco_vpfa::underlay_interface
  #  $mac = $::macaddress

  file {"/etc/vpe/vpfa/underlay_mac" :
    ensure => present,
    # This needs to be the mac address of the lead interface mapped to the VPP
    #content => $::macaddress,
  }
}
