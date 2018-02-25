group {'admin':
  ensure => 'present',
}

user {'admin':
  ensure     => 'present',
  managehome => true,
  home       => '/home/admin',
  groups     => ['wheel','admin'],
  shell      => '/bin/bash',
}
