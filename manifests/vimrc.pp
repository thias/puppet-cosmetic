# Class: cosmetic::vimrc
#
# Modify the main vimrc file with a few custom lines.
#
# Sample Usage :
#     include '::cosmetic::vimrc'
#
class cosmetic::vimrc (
  $lines  = [ 'set expandtab', 'set tabstop=2', 'set shiftwidth=2', ':sy on' ],
  $ensure = undef,
) {

  file { '/etc/vimrc':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('cosmetic/vimrc.erb'),
  }

}

