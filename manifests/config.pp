# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users::config
class users::config {
  $::users::package_users.each | $user_name, $user_details | {
    # If managehome is not set then set it to the package default
    $manage_home = $user_details[managehome] == undef ? {
      true   => $::users::manage_home,
      default => $user_details[managehome]
    }

    # Create user
    user { $user_name:
      ensure     => $user_details[ensure],
      comment    => $user_details[comment],
      password   => $user_details[password],
      managehome => $manage_home,
      groups     => $user_details[groups],
      shell      => $user_details[shell],
    }

    # Create authorized keys for the user
    $user_details[keys].each | $key_name, $key_details | {
      ssh_authorized_key { $key_name:
        ensure => $user_details[ensure],
        user   => $user_name,
        type   => "ssh-${key_details[type]}",
        key    => $key_details[key],
      }
    }
  }
}
