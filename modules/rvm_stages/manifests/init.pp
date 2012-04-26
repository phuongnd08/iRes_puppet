class rvm_stages {
  stage { "ruby": require => Stage["rvm-install"] }
  stage { "post-ruby": require => Stage["ruby"] }
}
