class webserver {
  include rvm
  stage { "ruby": require => Stage["rvm-install"] }
  class { 
    "webserver::ruby":
      stage => "ruby"
  }
}

