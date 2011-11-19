class mysql {
  package {
    "mysql": ensure => installed;
  }

  monit::package { "mysql": }
}
