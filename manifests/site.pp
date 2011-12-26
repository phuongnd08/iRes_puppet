node default {
  include monit
  include sshd
  include nginx
  include mysql
  include redis
  include push_server
  include resque
  include cron

  firewall { '010 INPUT allow reverse tunnel':
    action => accept,
    proto => 'tcp',
    dport => 3000,
    chain => 'INPUT',
  }

  resources { 'firewall':
    purge => true
  }
}

