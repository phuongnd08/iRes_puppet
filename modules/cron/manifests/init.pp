class cron {
  $working_dir = '/home/root/giasu_app/current'
  cron {
    refresh_user_score:
      command => "/usr/bin/env PATH=${env_path} /bin/sh -l -c 'cd ${working_dir} && bundle exec script/refresh_user_score'",
      hour => 0,
      minute => 1,
  }
}
