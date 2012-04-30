class webserver::passenger::nginx::ubuntu::post(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $nginx_prefix = '/opt/nginx',
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2',
  $passenger_version,
  $gempath,
  $binpath,
  $wrapperpath
) {

  exec {
    'passenger-install-nginx-module':
      command   => "${binpath}rvm ${ruby_version} exec passenger-install-nginx-module --auto --auto-download --prefix=${nginx_prefix}",
      creates   => "${nginx_prefix}/sbin/nginx",
      logoutput => 'on_failure',
      require   => [Rvm_gem['passenger'], Package['build-essential']],
  }

  class {
    "webserver::passenger::nginx::ubuntu::config":
      nginx_prefix => $nginx_prefix,
      require   => Exec["passenger-install-nginx-module"]
  }

  #
  #  file {
  #    '/etc/apache2/mods-available/passenger.load':
  #      ensure  => file,
  #      content => "LoadModule passenger_module ${gempath}/passenger-${version}/ext/apache2/mod_passenger.so",
  #      require => Exec['passenger-install-apache2-module'];
  #
  #    '/etc/apache2/mods-available/passenger.conf':
  #      ensure  => file,
  #      content => template('rvm/passenger-apache.conf.erb'),
  #      require => Exec['passenger-install-apache2-module'];
  #
  #    '/etc/apache2/mods-enabled/passenger.load':
  #      ensure  => 'link',
  #      target  => '../mods-available/passenger.load',
  #      require => File['/etc/apache2/mods-available/passenger.load'];
  #
  #    '/etc/apache2/mods-enabled/passenger.conf':
  #      ensure  => 'link',
  #      target  => '../mods-available/passenger.conf',
  #      require => File['/etc/apache2/mods-available/passenger.conf'];
  #  }

  #  # Add Apache restart hooks
  #  if defined(Service['apache']) {
  #    File['/etc/apache2/mods-available/passenger.load'] ~> Service['apache']
  #    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['apache']
  #    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache']
  #    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache']
  #  }
  #  if defined(Service['apache2']) {
  #    File['/etc/apache2/mods-available/passenger.load'] ~> Service['apache2']
  #    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['apache2']
  #    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['apache2']
  #    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['apache2']
  #  }
  #  if defined(Service['httpd']) {
  #    File['/etc/apache2/mods-available/passenger.load'] ~> Service['httpd']
  #    File['/etc/apache2/mods-available/passenger.conf'] ~> Service['httpd']
  #    File['/etc/apache2/mods-enabled/passenger.load']   ~> Service['httpd']
  #    File['/etc/apache2/mods-enabled/passenger.conf']   ~> Service['httpd']
  #  }
}
