node default {
  include monit
  include sshd
  include mysql
  include webserver
  include rvm
  include push_server

  #include redis
  #include resque
  #include cron
  #include my_firewall
}

