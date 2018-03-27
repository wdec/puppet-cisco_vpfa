# == Class ciscp_vpfa::service
#
# Configure and start the VPFA service.
#
class cisco_vpfa::service {
  service { 'vpfa' :
    ensure => $::cisco_vpfa::service_ensure,
    enable => $::cisco_vpfa::enabled,
    tag    => ['cisco-vts', 'neutron-db-sync-service'],
    # Require that fdio completes its configuration before
    require => Class['::fdio'],
    subscribe => Package['vpfa'],
  }
}
