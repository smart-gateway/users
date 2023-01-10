# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users
class users(
  Boolean $package_manage = true,
  Hash    $package_users = {},
  Bool    $manage_home = true,
) {

  # Ensure class declares subordinate classes
  contain users::install
  contain users::config
  contain users::service

  # Order operations
  anchor { '::users::begin': }
  -> Class['::users::install']
  -> Class['::users::config']
  -> Class['::users::service']
  -> anchor { '::users::end': }
}
