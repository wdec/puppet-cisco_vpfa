# == Class: cisco_vpfa::db::postgresql
#
# Class that configures postgresql for cisco_vpfa
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'cisco_vpfa'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'cisco_vpfa'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class cisco_vpfa::db::postgresql(
  $password,
  $dbname     = 'cisco_vpfa',
  $user       = 'cisco_vpfa',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  include ::cisco_vpfa::deps

  Class['cisco_vpfa::db::postgresql'] -> Service<| title == 'cisco_vpfa' |>

  ::openstacklib::db::postgresql { 'cisco_vpfa':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['cisco_vpfa'] ~> Exec<| title == 'cisco_vpfa-manage db_sync' |>

}
