class webserver {
  include rvm
  stage { "ruby": require => Stage["rvm-install"] }
  stage { "post-ruby": require => Stage["ruby"] }
  if ($rvm_installed == "true") {
    $ruby_version = "1.9.3-p125"
    $nginx_prefix = "/opt/nginx"
    class {
      "webserver::ruby":
        ruby_version => $ruby_version,
        stage => "ruby";
      "webserver::wrapper":
        ruby_version => $ruby_version,
        stage => "post-ruby";
      "webserver::passenger":
        ruby_version => $ruby_version,
        nginx_prefix => $nginx_prefix,
        stage => "post-ruby";
    }

    file {
      "${nginx_prefix}/conf/conf.d/sites-enabled":
        ensure => directory,
        recurse => true,
        force => true
    }

    file {
      "${nginx_prefix}/conf/conf.d/sites-enabled/ires.conf":
        ensure => present,
        recurse => true,
        content => template("webserver/ires.conf.erb"),
        require => File["${nginx_prefix}/conf/conf.d/sites-enabled"]
    }
  }
}

