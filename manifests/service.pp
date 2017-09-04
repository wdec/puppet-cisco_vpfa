# == Class ciscp_vpfa::service
#
# Configure and start the VPFA service.
#
class cisco_vpfa::service {
  service { 'vpfa' :
    ensure => running,
    enable => true,
  }
}
