class my_firewall{
  stage { 'pre': before => Stage['main'] }
  stage { 'post': require => Stage['main'] }

  firewall { '11 RH-Firewall-1-INPUT allow web server':
    action => accept,
    proto => 'tcp',
    state => 'NEW',
    dport => 80,
    chain => 'RH-Firewall-1-INPUT',
  }

  firewall { '12 RH-Firewall-1-INPUT allow ssh tunnel':
    action => accept,
    proto => 'tcp',
    state => 'NEW',
    dport => 22,
    chain => 'RH-Firewall-1-INPUT',
  }

  #  firewall { 'INPUT allow push server':
  #    action => accept,
  #    proto => 'tcp',
  #    dport => 3500,
  #    chain => 'INPUT',
  #  }

  firewall { '14 RH-Firewall-1-INPUT allow pinging':
    action => accept,
    proto => 'icmp',
    chain => 'RH-Firewall-1-INPUT',
  }

  firewall { '15 RH-Firewall-1-INPUT allow reverse tunnel for debugging':
    action => accept,
    proto => 'tcp',
    dport => 3000,
    chain => 'RH-Firewall-1-INPUT',
  }

  firewall { '16 RH-Firewall-1-INPUT reject all unknown access':
    action => reject,
    proto => 'all',
    chain => 'RH-Firewall-1-INPUT'
  }

  firewall { '21 INPUT redirect to RH-Firewall-1-INPUT':
    jump => 'RH-Firewall-1-INPUT',
    proto => 'all',
    chain => 'INPUT'
  }

  firewall { '22 FORWARD redirect to RH-Firewall-1-INPUT':
    jump => 'RH-Firewall-1-INPUT',
    proto => 'all',
    chain => 'FORWARD'
  }

  resources { 'firewall':
    purge => true
  }
}
