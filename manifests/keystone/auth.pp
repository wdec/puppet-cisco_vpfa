# == Class: cisco_vpfa::keystone::auth
#
# Configures cisco_vpfa user, service and endpoint in Keystone.
#
# === Parameters
#
# [*password*]
#   (required) Password for cisco_vpfa user.
#
# [*ensure*]
#   (optional) Ensure state of keystone service identity. Defaults to 'present'.
#
# [*auth_name*]
#   Username for cisco_vpfa service. Defaults to 'cisco_vpfa'.
#
# [*email*]
#   Email for cisco_vpfa user. Defaults to 'cisco_vpfa@localhost'.
#
# [*tenant*]
#   Tenant for cisco_vpfa user. Defaults to 'services'.
#
# [*configure_endpoint*]
#   Should cisco_vpfa endpoint be configured? Defaults to 'true'.
#
# [*configure_user*]
#   (Optional) Should the service user be configured?
#   Defaults to 'true'.
#
# [*configure_user_role*]
#   (Optional) Should the admin role be configured for the service user?
#   Defaults to 'true'.
#
# [*service_type*]
#   Type of service. Defaults to 'key-manager'.
#
# [*region*]
#   Region for endpoint. Defaults to 'RegionOne'.
#
# [*service_name*]
#   (optional) Name of the service.
#   Defaults to the value of 'cisco_vpfa'.
#
# [*service_description*]
#   (optional) Description of the service.
#   Default to 'cisco_vpfa FIXME Service'
#
# [*public_url*]
#   (optional) The endpoint's public url. (Defaults to 'http://127.0.0.1:FIXME')
#   This url should *not* contain any trailing '/'.
#
# [*admin_url*]
#   (optional) The endpoint's admin url. (Defaults to 'http://127.0.0.1:FIXME')
#   This url should *not* contain any trailing '/'.
#
# [*internal_url*]
#   (optional) The endpoint's internal url. (Defaults to 'http://127.0.0.1:FIXME')
#
class cisco_vpfa::keystone::auth (
  $password,
  $ensure              = 'present',
  $auth_name           = 'cisco_vpfa',
  $email               = 'cisco_vpfa@localhost',
  $tenant              = 'services',
  $configure_endpoint  = true,
  $configure_user      = true,
  $configure_user_role = true,
  $service_name        = 'cisco_vpfa',
  $service_description = 'cisco_vpfa FIXME Service',
  $service_type        = 'FIXME',
  $region              = 'RegionOne',
  $public_url          = 'http://127.0.0.1:FIXME',
  $admin_url           = 'http://127.0.0.1:FIXME',
  $internal_url        = 'http://127.0.0.1:FIXME',
) {

  include ::cisco_vpfa::deps

  if $configure_user_role {
    Keystone_user_role["${auth_name}@${tenant}"] ~> Service <| name == 'cisco_vpfa-server' |>
  }
  Keystone_endpoint["${region}/${service_name}::${service_type}"]  ~> Service <| name == 'cisco_vpfa-server' |>

  keystone::resource::service_identity { 'cisco_vpfa':
    ensure              => $ensure,
    configure_user      => $configure_user,
    configure_user_role => $configure_user_role,
    configure_endpoint  => $configure_endpoint,
    service_name        => $service_name,
    service_type        => $service_type,
    service_description => $service_description,
    region              => $region,
    auth_name           => $auth_name,
    password            => $password,
    email               => $email,
    tenant              => $tenant,
    public_url          => $public_url,
    internal_url        => $internal_url,
    admin_url           => $admin_url,
  }

}
