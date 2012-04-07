node default {
  include monit
  include sshd
  include mysql
  include rvm
  if $rvm_installed == "true" {
    rvm_system_ruby {
      'ruby-1.9.3-p0':
        ensure => 'present',
        default_use => true;
    }
  }
  #include push_server
  #include redis
  #include resque
  #include cron
  #include my_firewall
}

