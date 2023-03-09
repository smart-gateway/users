# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users::install
class users::install {

  # Make sure that zsh is installed
  if ! defined(Package['zsh']) {
    package { 'users package ensures zsh is installed':
      name   => 'zsh',
      ensure => 'installed',
    }
  }


  # Setup the Fish PPA
  if ! defined(Package['fish']) {
    apt::ppa  { 'ppa:fish-shell/release-3': }
    -> package { 'users package ensures fish is installed':
      name   => 'fish',
      ensure => 'installed',
    }
  }
}
