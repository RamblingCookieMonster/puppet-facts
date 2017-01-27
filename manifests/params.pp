class facts::params {

  $command    = $::osfamily ? {
    'Windows' => 'cmd /c mkdir',
    default   => 'mkdir -p'
  },

  $path       = $::osfamily ? {
    'Windows' => $::path,
    default   => '/bin'
  },

  $facterpath = $::osfamily ? {
    'Windows' => 'C:/ProgramData/PuppetLabs/facter/facts.d',
    default   => '/etc/facter/facts.d'
  },

  $group      = $::osfamily ? {
    'Windows' => 'Administrators',
    default   => 'root'
  },

  $owner      = $::osfamily ? {
    'Windows' => 'Administrators',
    default   => 'root'
  },

  $mode       = $::osfamily ? {
    'Windows' => '0775',
    default   => '0664'
  }
}
