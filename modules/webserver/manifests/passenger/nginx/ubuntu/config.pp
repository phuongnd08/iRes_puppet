class webserver::passenger::nginx::ubuntu::config {
  file {
    "${nginx_prefix}/conf/nginx.conf":
        ensure => present,
        content => template("webserver/nginx.conf.erb"),
        group => root
  }

  file {
    ["${nginx_prefix}/conf/conf.d", "${nginx_prefix}/conf/conf.d/sites-enabled"]:
      ensure => directory,
      recurse => true,
      force => true
  }

  monit::package {
    "nginx":
      content => template("webserver/nginx.monit.erb")
  }
}
