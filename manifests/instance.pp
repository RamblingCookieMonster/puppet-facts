# == Defined Type facts
#
define facts::instance (
  $ensure     = present,
  $command    = $::facts::params::command,
  $path       = $::facts::params::path,
  $facterpath = $::facts::params::facterpath,
  $factname   = $name,
  $value      = undef,
  $format     = 'txt',
  $group      = $::facts::params::group,
  $owner      = $::facts::params::owner,
  $mode       = $::facts::params::mode
) {
  include ::facts::params

  if versioncmp($::facterversion, '1.7') == -1 {
    fail('facts::instance requires a Facter version >= 1.7')
  }

  exec { "${name} ${command} ${facterpath}":
    command => "${command} ${facterpath}",
    creates => $facterpath,
    path    => $path,
  }
  case $format {
    default: {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => "${factname}=${value}",
        group   => $group,
        mode    => $mode,
        owner   => $owner,
      }
    }
    'yaml': {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => inline_template('<%= { @factname => @value}.to_yaml %>'),
        group   => $group,
        mode    => $mode,
        owner   => $owner,
      }
    }
    'json': {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => inline_template('<%= { @factname => @value}.to_json %>'),
        group   => $group,
        mode    => $mode,
        owner   => $owner,
      }
    }
  }
}
