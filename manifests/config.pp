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
class cisco_vpfa::config (
  $cisco_vpfa_config = {},
) {

  include ::cisco_vpfa::deps

  validate_hash($cisco_vpfa_config)

  create_resources('cisco_vpfa_config', $cisco_vpfa_config)
}
