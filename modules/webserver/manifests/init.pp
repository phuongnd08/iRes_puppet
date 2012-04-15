class webserver {
  include rvm
  stage { "ruby": require => Stage["rvm-install"] }
  stage { "post-ruby": require => Stage["ruby"] }
  if ($rvm_installed == "true") {
    class {
      "webserver::ruby":
        stage => "ruby";
      "webserver::wrapper":
        stage => "post-ruby";
      "webserver::passenger":
        stage => "post-ruby";
    }
  }
}

