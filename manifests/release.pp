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

    # Cleanly disable to remove symlinks *before* removing the init script
    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease >= 7 {
      exec { 'systemctl disable release.service; rm -f /lib/systemd/system/release.service':
        onlyif => 'test -f /lib/systemd/system/release.service',
        path   => [ '/bin', '/usr/bin' ],
      }
    } else {
      exec { 'chkconfig --del release; rm -f /etc/init.d/release':
        onlyif => 'test -f /etc/init.d/release',
        path   => [ '/sbin', '/bin', '/usr/bin' ],
      }
    }

  } else {

    package { 'linux_logo': ensure => installed }

    file { '/usr/local/bin/release':
      content => template('cosmetic/release.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['linux_logo'],
    }

    if $::osfamily == 'RedHat' and $::operatingsystemmajrelease >= 7 {
      file { '/lib/systemd/system/release.service':
        content => template('cosmetic/release.systemd.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['release'],
        require => File['/usr/local/bin/release'],
      }
    } else {
      # The 'release' service to create nice issue/motd files
      file { '/etc/init.d/release':
        content => template('cosmetic/release.init.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0755',
        notify  => Service['release'],
        require => File['/usr/local/bin/release'],
      }
    }

    service { 'release':
      enable => true,
    }

  }

}

