# == Class: cisco_vpfa
#
# Full description of class cisco_vpfa here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class cisco_vpfa (
  $vts_username,
  $vts_password,
  $vts_address,
  $vts_registration_api,
  $hostname,
  $network_config_method,
  $network_ipv4_address,
  $network_ipv4_mask,
  $network_ipv4_gateway,
  $compute_hostname,
  $network_nameserver,
  $vif_type,
  $underlay_if_name,
  $bond_if_list,
  $underlay_ip_net_list,
  $package_ensure   = 'present'

) {

  #include ::cisco_vpfa::deps
  include ::cisco_vpfa::params

  # Validate OS
  case $::operatingsystem {
    'centos', 'redhat': {
      if $::operatingsystemmajrelease != '7' {
        # RHEL/CentOS versions < 7 not supported as they lack systemd
        fail("Unsupported OS: ${::operatingsystem} ${::operatingsystemmajrelease}")
      }
    }
    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }

  ensure_resource('package', 'vpfa',
    {
      ensure => $package_ensure,
    }
  )

  class { '::cisco_vpfa::config': }
  ~> class { '::cisco::service': }
  -> Class['::cisco_vpfa']


}
