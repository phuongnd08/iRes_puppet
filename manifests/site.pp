node default {
  include monit
  include sshd
  include nginx
  include mysql
  include redis
  include push_server
  include resque
  include cron
}

