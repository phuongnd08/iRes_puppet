class rvm_ruby {
  stage { "ruby": require => Stage["rvm-install"] }
  stage { "post-ruby": require => Stage["ruby"] }
}
