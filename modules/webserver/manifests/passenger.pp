class webserver::passenger {
  class {
    'webserver::passenger::nginx':
      version => '3.0.11',
      ruby_version => 'ruby-1.9.3-p125',
      mininstances => '3',
      maxinstancesperapp => '0',
      maxpoolsize => '30',
      spawnmethod => 'smart-lv2';
  }
}
