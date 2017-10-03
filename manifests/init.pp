#
# Copyright (C) 2017 cisco Inc.
#
# Author: Wojciech Dec <wdec@cisco.com>
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# == Class: cisco_vpfa
#
# Puppet module for configuring and running the cisco VTS VPFA agent.
#
# === Parameters
#
# [*vts_username*]
# (required) The VTS controller username
# Example: 'admin'
#
# [*vts_password*]
# (required) The VTS controller password
# Example: 'admin'
#
# [*vts_address*]
# (required) The IP or domain name of the VTS controller
# Example: '127.1.1.1'
#
# [*vts_address*]
# (required) The IP or domain name of the VTS controller
# Example: '127.1.1.1'
#
# [*vts_registration_api*]
# (required) The URL for the VTFA registration API on the VTS
# Example: 'https://<IP or FQDN of VTS>:8888/api/running/cisco-vts/vtfs/vtf'
#
# [*vpfa_hostname*]
# (optional) The VPFA's  host name
# Example: 'vpfa-1'
#
# [*compute_hostname*]
# (optional) The host's host name (as registered in Openstack compute)
# Example: 'compute-node-1'
#
# [*network_config_method*]
# (optional) The host's network config method
# Example: 'static'
#
# [*network_ipv4_address*]
# (required) The VPFA's underlay IPv4 address
# Example: '10.0.0.10'
#
# [*network_ipv4_mask*]
# (required) The VPFA's underlay IP subnet length
# Example: '/24'
#
# [*network_ipv4_gateway*]
# (required) The VPFA's default IP gateway on the underlay
# Example: '10.0.0.1'
#
# [*network_ipv4_address*]
# (required) The VPFA's underlay IP address
# Example: '10.0.0.10'
#
# [*network_nameserver*]
# (optional) The nameserver IP address
# Example: '10.0.0.10'
#
# [*vif_type*]
# (optional) The vif-type to use
# Example: 'vhost-user'
#
# [*underlay_interface*]
# (required) List of the underlay interfaces or "bond"
# Example: 'ens224, ens225'
#
# [*bond_if_list*]
# (optional) List of the underlay interfaces used for "bonding"
# Example: 'ens224, ens225'
#
# [*underlay_ip_net_list*]
# (optional) List of other underlay IP subnets
# Example: '10.0.1.0/24, 10.0.2.0/24'
#
# [*vtsr_ip_address_list*]
# List of VTSR IPs on the underlay network
# Example: '10.0.1.1, 10.0.1.2'
#

class cisco_vpfa (
  $vts_username,
  $vts_password,
  $vts_address,
  $vts_registration_api,
  $vpfa_hostname            = $::cisco_vpfa::params::vpfa_hostname,
  $network_config_method    = $::cisco_vpfa::params::vts_network_config_method,
  $network_ipv4_address,
  $network_ipv4_mask,
  $network_ipv4_gateway,
  $compute_hostname         = $::cisco_vpfa::params::compute_hostname,
  $network_nameserver       = $::cisco_vpfa::params::network_nameserver,
  $vif_type                 = $::cisco_vpfa::params::vif_type,
  $underlay_interface,
  $bond_if_list             = $::cisco_vpfa::params::bond_if_list,
  $underlay_ip_net_list     = $::cisco_vpfa::params::underlay_ip_net_list,
  $package_ensure           = $::cisco_vpfa::params::package_ensure,
  $vtsr_ip_address_list     = $::cisco_vpfa::params::vtsr_ip_address_list,
  $username                 = $::cisco_vpfa::params::username,
  $password_hash            = $::cisco_vpfa::params::password_hash

) inherits ::cisco_vpfa::params {

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
  ~> class { '::cisco_vpfa::service': }

}
