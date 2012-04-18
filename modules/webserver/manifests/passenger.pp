class webserver::passenger(
  $ruby_version,
  $nginx_prefix
) {
  class {
    'webserver::passenger::nginx':
      version => '3.0.11',
      ruby_version => $ruby_version,
      nginx_prefix => $nginx_prefix,
      mininstances => '3',
      maxinstancesperapp => '0',
      maxpoolsize => '30',
      spawnmethod => 'smart-lv2';
  }
}
