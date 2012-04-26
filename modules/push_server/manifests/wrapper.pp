class push_server::wrapper (
  $ruby_version
) {
  rvm_gemset {
    "${ruby_version}@push_app":
      ensure => present,
      require => Rvm_system_ruby[$ruby_version];
  }
}
