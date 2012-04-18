class webserver::wrapper(
  $ruby_version
) {
  rvm_gemset {
    "${ruby_version}@ires":
      ensure => present,
      require => Rvm_system_ruby[$ruby_version];
  }
}
