node default {
  include monit
  include sshd
  include nginx
  include mysql
  #include push_server
  #include redis
  #include resque
  #include cron
  #include my_firewall
}

