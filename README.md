# login_defs

[![Build Status](https://github.com/gibbs/puppet-login_defs/workflows/CI/badge.svg)](https://github.com/gibbs/puppet-login_defs/actions?query=workflow%3ACI)
[![Release](https://github.com/gibbs/puppet-login_defs/workflows/Release/badge.svg)](https://github.com/gibbs/puppet-login_defs/actions?query=workflow%3ARelease)
[![Puppet Forge](https://img.shields.io/puppetforge/v/genv/login_defs.svg?maxAge=2592000?style=plastic)](https://forge.puppet.com/genv/login_defs)
[![Apache-2 License](https://img.shields.io/github/license/gibbs/puppet-login_defs.svg)](LICENSE)

Configure and manage the `/etc/login.defs` file that defines site-specific
configuration for the shadow password suite.

## Usage

Including `login_defs` will manage `/etc/login.defs` with the default
configuration supplied by supported distributions:

```puppet
include login_defs
```

To manage the file permissions:

```puppet
class { 'login_defs':
  owner => 0,
  group => 0,
  mode  => '0644',
}
```

### Configuration Examples

The `options` parameter accepts a hash of `value`, `comment` and `enabled`.

- When `enabled` is false the setting will be commented out.
- The `comment` parameter is used to maintain comments in the file.

#### Manifest Example

```puppet
# Manifest example
class { 'login_defs':
  mode    => '0644',
  options => {
    'PASS_MAX_DAYS' => {
      value   => 30,
      comment => 'Maximum number of days a password may be used.',
    },
    'DEFAULT_HOME' => {
      value   => 'yes',
      enabled => false,
    }
  }
}
```

#### Hiera Example

```yaml
login_defs::mode: '0644'
login_defs::options:
  PASS_MAX_DAYS:
    value: 30
    comment: Maximum number of days a password may be used.

  DEFAULT_HOME:
    value: 'yes'
    enabled: false

  TTYGROUP:
    value: tty
    comment: |-
      If you have a "write" program which is "setgid" to a special group
      which owns the terminals, define TTYGROUP to the group number and
      TTYPERM to 0620.  Otherwise leave TTYGROUP commented out and assign
      TTYPERM to either 622 or 600.
  TTYPERM:
    value: '0600'
```

### Managing the Package

This module will not, by default, manage the `login` (Debian) or
`shadow-utils` (RedHat) package. This can be enabled and customised with:

```puppet
class { 'login_defs':
  package_manage => true,
  package_ensure => 'installed',
  package_name   => undef,
}
```
