class webserver::wrapper {
  rvm_gemset {
    "ruby-1.9.3-p125@ires":
      ensure => present,
      require => Rvm_system_ruby['ruby-1.9.3-p125'];
  }
}
