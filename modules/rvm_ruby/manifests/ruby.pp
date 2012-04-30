class rvm_ruby::ruby(
  $ruby_version
) {
  rvm_system_ruby {
    $ruby_version:
      ensure => 'present',
      default_use => true;
  }
}
