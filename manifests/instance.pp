# == Defined Type facts
#
define facts::instance (
  $ensure     = present,
  $facterpath = '/etc/facter/facts.d',
  $factname   = $name,
  $value      = undef,
  $format     = 'txt',
) {

  if versioncmp($::facterversion, '1.7') == -1 {
    fail('facts::instance requires a Facter version >= 1.7')
  }

  # OS specifics
  $command    = $::osfamily ? {
    'Windows' => 'cmd /c mkdir',
    default   => 'mkdir -p'
  }
  $path       = $::osfamily ? {
    'Windows' => $::path,
    default   => '/bin'
  }
  $group      = $::osfamily ? {
    'Windows' => 'Administrators',
    default   => 'root'
  }
  $owner      = $::osfamily ? {
    'Windows' => 'Administrators',
    default   => 'root'
  }
  $mode       = $::osfamily ? {
    'Windows' => '0775',
    default   => '0664'
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
