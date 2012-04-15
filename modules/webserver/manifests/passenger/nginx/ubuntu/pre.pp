class webserver::passenger::nginx::ubuntu::pre {

  if ! defined(Package['build-essential'])      { package { 'build-essential':      ensure => installed } }
  #if ! defined(Package['libapr1-dev'])          { package { 'libapr1-dev':          ensure => installed, alias => 'libapr-dev' } }
  #if ! defined(Package['libaprutil1-dev'])      { package { 'libaprutil1-dev':      ensure => installed, alias => 'libaprutil-dev' } }
  if ! defined(Package['libcurl4-openssl-dev']) { package { 'libcurl4-openssl-dev': ensure => installed } }
}
