# puppet-cosmetic

## Overview

Cosmetic configuration changes. Purely a matter of taste. Initially only tested
on Red Hat Enterprise Linux, but changes to support more distributions are very
welcome.

* `cosmetic::bash` : Change bash prompt and a few other minor tweaks.
* `cosmetic::release` : Create nice looking release and motd files.
* `cosmetic::vimrc` : Tweak the original global vimrc to change indentation.

## Examples

Change bash prompt to include some color, different for root (red vs. green) :

```puppet
class { '::cosmetic::bash':
  # Green user with blue directory
  ps1      => '[\[\033[01;32m\]\u\[\033[00m\]@\h\[\033[01;34m\] \W\[\033[00m\]]\$ ',
  # Red user with blue directory
  ps1_root => '[\[\033[01;31m\]\u\[\033[00m\]@\h\[\033[01;34m\] \W\[\033[00m\]]\$ ',
}
```

The exact same, from hieradata :

```yaml
---
classes:
  - '::cosmetic::bash'
cosmetic::bash::ps1: '[\[\033[01;32m\]\u\[\033[00m\]@\h \[\033[01;34m\]\W\[\033[00m\]]\$ '
cosmetic::bash::ps1_root: '[\[\033[01;31m\]\u\[\033[00m\]@\h \[\033[01;34m\]\W\[\033[00m\]]\$ '
```

