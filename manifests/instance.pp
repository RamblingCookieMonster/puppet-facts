# == Defined Type facts
#
define facts::instance (
  $ensure     = present,
  $command    = 'mkdir -p',
  $facterpath = '/etc/facter/facts.d',
  $factname   = $name,
  $value      = undef,
  $format     = 'txt',
) {

  if versioncmp($::facterversion, '1.7') == -1 {
    fail('facts::instance requires a Facter version >= 1.7')
  }

  exec { "${name} ${command} ${facterpath}":
    command => "${command} ${facterpath}",
    creates => $facterpath,
    path    => '/bin',
  }
  case $format {
    default: {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => "${factname}=${value}",
        group   => 'root',
        mode    => '0664',
        owner   => 'root',
      }
    }
    'yaml': {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => inline_template('<%= { @factname => @value}.to_yaml %>'),
        group   => 'root',
        mode    => '0664',
        owner   => 'root',
      }
    }
    'json': {
      file { "${facterpath}/${factname}.${format}":
        ensure  => $ensure,
        content => inline_template('<%= { @factname => @value}.to_json %>'),
        group   => 'root',
        mode    => '0664',
        owner   => 'root',
      }
    }
  }
}
