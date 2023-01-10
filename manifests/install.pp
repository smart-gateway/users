# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users::install
class users::install {

  # Make sure that zsh is installed
  package { 'zsh':
    ensure => 'installed',
  }

  # Setup the Fish PPA
  apt::ppa  { 'ppa:fish-shell/release-3': }
  -> package { 'fish':
    ensure => 'installed',
  }

}
