class mysql {
  package {
    "mysql-server": ensure => installed;
  }

  monit::package { "mysql": }
  $db_names = "iRes_prod"
  $db_backup_dir = "/var/backup/mysql/data"

  file {
    ["/var/backup", "/var/backup/mysql", "/var/backup/mysql/data"]:
      ensure => directory;
    '/var/backup/mysql/autobackup.sh':
      content => template('mysql/autobackup.sh.erb'),
      mode => 0700
  }
}

define mysql::mysqldb {
  exec { "create-${name}-db":
    unless => "/usr/bin/mysql -uroot ${name}",
    command => "/usr/bin/mysql -uroot -e 'create database ${name}'",
    require => Package["mysql-server"],
  }
}
