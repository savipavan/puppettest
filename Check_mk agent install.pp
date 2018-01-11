class check_mk::agent::install (
  $version,
  $filestore,
  $workspace,
) {
  if ! defined(Package['xinetd']) {
    package { 'xinetd':
      ensure => present,
    }
  }
  if $filestore {
    if ! defined(File[$workspace]) {
      file { $workspace:
        ensure => directory,
      }
    }
    file { "${workspace}/check_mk-agent-${version}.noarch.rpm":
      ensure  => present,
      source  => "${filestore}/check_mk-agent-${version}.noarch.rpm",
      require => Package['xinetd'],
    }
    package { 'check_mk-agent':
      ensure   => present,
      provider => 'rpm',
      source   => "${workspace}/check_mk-agent-${version}.noarch.rpm",
      require  => File["${workspace}/check_mk-agent-${version}.noarch.rpm"],
    }
    
      ],
    }
  }
  else {
    package { 'check_mk-agent':
      ensure  => present,
      require => Package['xinetd'],
    }
    }
}