class webserver {
  include rvm
  include rvm_ruby
  include mysql

  package {
    "cups-bsd": ensure => installed;
  }

  class {
    "webserver::network":
      ip => $network_ip,
      broadcast => $network_bcast,
      gateway => $network_gateway
  }

  if ($rvm_installed == "true") {
    $ruby_version = "1.9.3-p125"
    $nginx_prefix = "/opt/nginx"

    if ! defined(Class['rvm_ruby::ruby']) {
      class {
        "rvm_ruby::ruby":
          ruby_version => $ruby_version,
          stage => "ruby";
      }
    }

    class {
      "webserver::wrapper":
        ruby_version => $ruby_version,
        stage => "post-ruby";
      "webserver::passenger":
        ruby_version => $ruby_version,
        nginx_prefix => $nginx_prefix,
        stage => "post-ruby";
      "webserver::ires":
        nginx_prefix => $nginx_prefix,
        stage => "post-ruby";
    }
  }
}

