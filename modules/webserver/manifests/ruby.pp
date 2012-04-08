class webserver::ruby {
  rvm_system_ruby {
    'ruby-1.9.3-p0':
      ensure => 'present',
      default_use => true;
  }
}
