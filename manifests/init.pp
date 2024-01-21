# @summary
#   Manage the configuration control definitions for the login package
#
# @api public
#
# @param options
#   A hash of options to configure /etc/login.defs
#
# @param package_ensure
#   The login/shadow util package state to use when using $package_manage
#
# @param package_manage
#   Set to true to manage the login/shadow utility package
#
# @param package_name
#   The package name to use when managing the login/shadow utility package
#
# @param owner
#   The owner to set on /etc/login.defs
#
# @param group
#   The group to set on /etc/login.defs
#
# @param mode
#   The mode to set on /etc/login.defs
#
# @author Dan Gibbs <dev@dangibbs.co.uk>
#
class login_defs (
  Hash[String, Login_Defs::Option] $options = undef,
  String $package_ensure                    = 'installed',
  Boolean $package_manage                   = false,
  String[1] $package_name                   = undef,
  Variant[String[1], Integer] $owner        = 'root',
  Variant[String[1], Integer] $group        = 0,
  String[3,4] $mode                         = '0644',
) {
  if $package_manage {
    package { $package_name:
      ensure => $package_ensure,
    }
  }

  file { '/etc/login.defs':
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp("${module_name}/login.defs.epp", {
        options => lookup('login_defs::options') + $options,
    }),
  }
}
