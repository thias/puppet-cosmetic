# Class: cosmetic::release
#
# Create useful and nice looking motd and issue files using linux_logo.
#
# Sample Usage :
#     include '::cosmetic::release'
#
class cosmetic::release (
  $format_string = '$R - Linux $V\\n#N #M #X #T cpu#S with #R RAM\\n-> #H <-\n',
  $ensure        = 'present',
) {

  if $ensure == 'absent' {

    # Cleanly remove with chkconfig *before* removing the init script
    exec { '/sbin/chkconfig --del release; /bin/rm -f /etc/init.d/release':
      onlyif => '/usr/bin/test -f /etc/init.d/release',
    }

  } else {

    package { 'linux_logo': ensure => installed }

    # The 'release' service to create nice issue/motd files
    file { '/etc/init.d/release':
      content => template('cosmetic/release.init.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify  => Service['release'],
      require => Package['linux_logo'],
    }
    service { 'release':
      enable    => true,
      hasstatus => true,
    }

  }

}

