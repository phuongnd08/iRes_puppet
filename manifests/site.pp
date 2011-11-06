node default {
  include nginx
  include monit
  monit::package { "nginx": }
  monit::package { "mysql": }
  monit::package { "push_server": }
}

