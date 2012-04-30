class webserver::passenger::nginx::ubuntu::config(
  $nginx_prefix
){
  file {
    "${nginx_prefix}/conf/nginx.conf":
      ensure => present,
      content => template("webserver/nginx.conf.erb"),
      group => root,
      notify => Exec["restart-nginx"]
  }

  file {
    ["${nginx_prefix}/conf/conf.d", "${nginx_prefix}/conf/conf.d/sites-enabled"]:
      ensure => directory,
      recurse => true,
      force => true,
      notify => Exec["restart-nginx"]
  }

  exec {
    "restart-nginx":
      command =>"${nginx_prefix}/sbin/nginx -s reload"
  }

  monit::package {
    "nginx":
      content => template("webserver/nginx.monit.erb")
  }
}
