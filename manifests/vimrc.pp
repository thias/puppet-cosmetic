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

  # The base file has changed quite a bit, so rebase for EL9+
  if versioncmp($::operatingsystemmajrelease, '9') >= 0 {
    $template = 'vimrc-el9'
  } else {
    $template = 'vimrc'
  }

  file { '/etc/vimrc':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("cosmetic/${template}.erb"),
  }

}

