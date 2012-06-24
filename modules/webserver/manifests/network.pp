class webserver::network(
  $ip,
  $broadcast,
  $gateway
) {
  file { "/etc/network/interfaces":
    owner => root,
    group => root,
    mode => 644,
    content => template("webserver/network.erb")
  }
}
