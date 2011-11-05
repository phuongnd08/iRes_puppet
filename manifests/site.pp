node default {
  include monit
  monit::package { "mysql": }
}
