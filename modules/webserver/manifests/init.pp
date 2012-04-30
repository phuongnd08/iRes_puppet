class webserver {
  include rvm
  include rvm_ruby
  include mysql
  if ($rvm_installed == "true") {
    $ruby_version = "1.9.3-p125"
    $nginx_prefix = "/opt/nginx"
    class {
      "rvm_ruby::ruby":
        ruby_version => $ruby_version,
        stage => "ruby";
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

