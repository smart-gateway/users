# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users::config
class users::config {
  $::users::package_users.each | $username, $user_details | {
    # If managehome is not set then set it to the package default
    $manage_home = $user_details[managehome] == undef ? {
      true   => $::users::manage_home,
      default => $user_details[managehome]
    }

    # Create user
    user { $username:
      ensure     => $user_details[ensure],
      password   => $user_details[password],
      managehome => $manage_home,
      groups     => $user_details[groups],
      shell      => $user_details[shell],
      keys       => $user_details[keys],
    }
  }
}
