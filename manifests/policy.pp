# == Class: cisco_vpfa::policy
#
# Configure the cisco_vpfa policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for cisco_vpfa
#   Example :
#     {
#       'cisco_vpfa-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'cisco_vpfa-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/cisco_vpfa/policy.json
#
class cisco_vpfa::policy (
  $policies    = {},
  $policy_path = '/etc/cisco_vpfa/policy.json',
) {

  include ::cisco_vpfa::deps

  validate_hash($policies)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'cisco_vpfa_config': policy_file => $policy_path }

}
