# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include users::install
class users::install {

  # Make sure that zsh is installed
  ensure_packages(['zsh'], { ensure => 'present' })

  # # Setup the Fish PPA
  # apt::ppa  { 'ppa:fish-shell/release-3': }
  # ensure_packages(['fish'], { ensure => 'present'})
}
