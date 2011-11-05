node "www.giasudientu.com" {
  include monit
  monit::package { "mysql": }
}
