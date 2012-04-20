class webserver::ires(
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
}
