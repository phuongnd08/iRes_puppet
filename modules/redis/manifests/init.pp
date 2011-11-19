class redis {
  package {
    "redis":
      ensure => installed
  }

  monit::package { "redis": }
}
