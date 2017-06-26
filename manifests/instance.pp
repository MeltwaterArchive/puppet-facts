# == Defined Type facts
#
define facts::instance (
  $ensure = present,
  $facterpath = '/etc/facter/facts.d',
  $factname = $name,
  $value = undef,
  $group = 'root',
  $owner = 'root',
) {

  if versioncmp($::facterversion, '1.7') == -1 {
    fail('facts::instance requires a Facter version >= 1.7')
  }

  exec { "${name} mkdir -p /etc/facter/facts.d/":
    command => 'mkdir -p /etc/facter/facts.d/',
    creates => '/etc/facter/facts.d/',
    path    => '/bin',
  }

  file { "${facterpath}/${factname}.txt":
    ensure  => $ensure,
    content => "${factname}=${value}",
    group   => $group,
    mode    => '0664',
    owner   => $owner,
  }
}
