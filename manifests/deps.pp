# == Class: cisco_vpfa::deps
#
# cisco_vpfa anchors and dependency management
#
class cisco_vpfa::deps {
  # Setup anchors for install, config and service phases of the module.  These
  # anchors allow external modules to hook the begin and end of any of these
  # phases.  Package or service management can also be replaced by ensuring the
  # package is absent or turning off service management and having the
  # replacement depend on the appropriate anchors.  When applicable, end tags
  # should be notified so that subscribers can determine if installation,
  # config or service state changed and act on that if needed.
  anchor { 'cisco_vpfa::install::begin': }
  -> Package<| tag == 'cisco_vpfa-package'|>
  ~> anchor { 'cisco_vpfa::install::end': }
  -> anchor { 'cisco_vpfa::config::begin': }
  -> Cisco_vpfa_config<||>
  ~> anchor { 'cisco_vpfa::config::end': }
  -> anchor { 'cisco_vpfa::db::begin': }
  -> anchor { 'cisco_vpfa::db::end': }
  ~> anchor { 'cisco_vpfa::dbsync::begin': }
  -> anchor { 'cisco_vpfa::dbsync::end': }
  ~> anchor { 'cisco_vpfa::service::begin': }
  ~> Service<| tag == 'cisco_vpfa-service' |>
  ~> anchor { 'cisco_vpfa::service::end': }

  # all db settings should be applied and all packages should be installed
  # before dbsync starts
  Oslo::Db<||> -> Anchor['cisco_vpfa::dbsync::begin']

  # policy config should occur in the config block also.
  Anchor['cisco_vpfa::config::begin']
  -> Openstacklib::Policy::Base<||>
  ~> Anchor['cisco_vpfa::config::end']

  # Installation or config changes will always restart services.
  Anchor['cisco_vpfa::install::end'] ~> Anchor['cisco_vpfa::service::begin']
  Anchor['cisco_vpfa::config::end']  ~> Anchor['cisco_vpfa::service::begin']
}
