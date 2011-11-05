node default {
  include monit
  monit::package { "nginx": }
  monit::package { "mysql": }
}

