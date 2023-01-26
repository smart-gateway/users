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
      true   => $::users::home_manage,
      default => $user_details[managehome]
    }

    # Add zsh customizations if specified
    if $user_details[shell-custom][p10k] == true {
      vcsrepo { "/home/$user_name/.oh-my-zsh/custom/themes/powerlevel10k":
        ensure   => present,
        provider => git,
        source   => 'https://github.com/romkatv/powerlevel10k.git',
        depth    => 1,
        user     => $user_name,
      }
    }

    if $user_details[shell-custom][ohmyzsh] == true {
      ohmyzsh::install { $user_name:
        set_sh => true,
      }

      ohmyzsh::theme { $user_name:
        theme => 'powerlevel10k/powerlevel10k',
      }
    }
    # [shell-custom]
    # [shell-custom][p10k]
    # [shell-custom][ohmyzsh]

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
      ssh_authorized_key { "${user_name}_${key_name}":
        ensure => $user_details[ensure],
        user   => $user_name,
        type   => "ssh-${key_details[key_type]}",
        key    => $key_details[key_value],
      }
    }
  }
}
