class mysql {
  package {
    "mysql": ensure => installed;
  }

  monit::package { "mysql": }
  $db_names = "giasu_prod"
  $db_backup_dir = "/var/backup/mysql/data"

  file {
    ["/var/backup", "/var/backup/mysql", "/var/backup/mysql/data"]:
      ensure => directory;
    '/var/backup/mysql/autobackup.sh':
      content => template('mysql/autobackup.sh.erb'),
      mode => 0700
  }
}
