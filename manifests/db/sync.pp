#
# Class to execute cisco_vpfa-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the cisco_vpfa-dbsync command.
#   Defaults to undef
#
class cisco_vpfa::db::sync(
  $extra_params  = undef,
) {

  include ::cisco_vpfa::deps

  exec { 'cisco_vpfa-db-sync':
    command     => "cisco_vpfa-manage db_sync ${extra_params}",
    path        => [ '/bin', '/usr/bin', ],
    user        => 'cisco_vpfa',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    logoutput   => on_failure,
    subscribe   => [
      Anchor['cisco_vpfa::install::end'],
      Anchor['cisco_vpfa::config::end'],
      Anchor['cisco_vpfa::dbsync::begin']
    ],
    notify      => Anchor['cisco_vpfa::dbsync::end'],
  }
}
