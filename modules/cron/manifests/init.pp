class cron {
  $working_dir = '/home/root/giasu_app/current'
  cron {
    refresh_user_score:
      command => "/usr/bin/env PATH=${env_path} /bin/sh -l -c 'cd ${working_dir} && bundle exec script/cron'",
      hour => 0,
      minute => 1;
    backup_mysql:
      command => "/var/backup/mysql/autobackup.sh",
      hour => 1,
      minute => 0
  }
}
