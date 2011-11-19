node default {
  include monit
  include nginx
  include mysql
  include redis
  monit::package { "push_server": }
  monit::package { "sshd": }
}

