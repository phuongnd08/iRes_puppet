class webserver::network(
  $ip,
  $broadcast,
  $gateway
) {
  file { "/etc/network/interfaces":
    owner => root,
    group => root,
    mode => 644,
    content => template("webserver/network/interfaces.erb")
  }

  file { "/etc/resolv.conf":
    owner => root,
    group => root,
    mode => 644,
    content => template("webserver/network/resolv.erb")
  }

}
