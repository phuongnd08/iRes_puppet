class webserver::ires(
  $ruby_version,
  $nginx_prefix
) {

  package {
    "libmysqlclient-dev":
      ensure => present;
    "nodejs":
      ensure => present;
  }

  file {
    "${nginx_prefix}/conf/conf.d/sites-enabled/ires.conf":
      ensure => present,
      recurse => true,
      content => template("webserver/ires.conf.erb"),
      require => File["${nginx_prefix}/conf/conf.d/sites-enabled"]
  }

  mysql::mysqldb {
    "iRes_prod":
  }

  $gemset = "${ruby_version}@ires"
  $rvmshell = "/usr/local/rvm/bin/rvm-shell"
  monit::package {
    "ires":
      content => template("webserver/ires.monit.erb")
  }
}
