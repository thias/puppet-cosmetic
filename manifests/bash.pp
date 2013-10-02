# Class: cosmetic::bash
#
# Modify globally some simple cosmetic aspects of the bash shell.
#
# Sample Usage :
#  include '::cosmetic::bash'
#  class { '::cosmetic::bash':
#    # Blue directory
#    ps1 => '[\u@\h \[\033[01;34m\]\W\[\033[00m\]]\$ ',
#  }

class cosmetic::bash (
  $histtimeformat = '%Y%m%d %H:%M:%S ',
  $ps1            = undef,
  $ps1_root       = undef,
  $ensure         = undef,
) {

  file { '/etc/profile.d/cosmetic.sh':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/cosmetic.sh.erb"),
  }

}

