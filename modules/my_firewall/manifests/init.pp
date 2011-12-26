class my_firewall{
  stage { 'pre': before => Stage['main'] }
  stage { 'post': require => Stage['main'] }

  class {
    "my_firewall::accept":
      stage => 'pre';

    "my_firewall::reject":
      stage => 'post';
  }

  resources { 'firewall':
    purge => true
  }

  firewall { '01 INPUT redirect to MINE':
    action => 'MINE',
    proto => 'all',
    chain => 'INPUT'
  }

  firewall { '02 FORWARD redirect to MINE':
    action => 'MINE',
    proto => 'all',
    chain => 'FORWARD'
  }

  include my_firewall::accept
  include my_firewall::reject
}


class my_firewall::accept {
  firewall { '01 MINE allow web server':
    action => accept,
    proto => 'tcp',
    state => 'NEW',
    dport => 80,
    chain => 'MINE',
  }

  firewall { '02 MINE allow ssh tunnel':
    action => accept,
    proto => 'tcp',
    state => 'NEW',
    dport => 22,
    chain => 'MINE',
  }

  #  firewall { 'INPUT allow push server':
  #    action => accept,
  #    proto => 'tcp',
  #    dport => 3500,
  #    chain => 'INPUT',
  #  }

  firewall { '04 MINE allow pinging':
    action => accept,
    proto => 'icmp',
    chain => 'MINE',
  }

  firewall { '05 MINE allow reverse tunnel for debugging':
    action => accept,
    proto => 'tcp',
    dport => 3000,
    chain => 'MINE',
  }
}

class my_firewall::reject {
  firewall { '06 MINE reject all unknown access':
    action => reject,
    proto => 'all',
    chain => 'MINE'
  }
}
