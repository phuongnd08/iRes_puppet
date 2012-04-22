class webserver::passenger::nginx(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $nginx_prefix,
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2'
) {

  case $operatingsystem {
    Ubuntu: { include webserver::passenger::nginx::ubuntu::pre }
  }

  class {
    'rvm::passenger::gem':
      ruby_version => $ruby_version,
      version => $version,
  }

  # TODO: How can we get the gempath automatically using the ruby version
  # Can we read the output of a command into a variable?
  # e.g. $gempath = `usr/local/rvm/bin/rvm ${ruby_version} exec rvm gemdir`
  $gempath = "${rvm_prefix}rvm/gems/ruby-${ruby_version}/gems"
  $binpath = "${rvm_prefix}rvm/bin/"
  $wrapperpath = "${rvm_prefix}rvm/wrappers/ruby-${ruby_version}/ruby"

  case $operatingsystem {
    Ubuntu: {
      class { 'webserver::passenger::nginx::ubuntu::post':
        ruby_version       => $ruby_version,
        version            => $version,
        rvm_prefix         => $rvm_prefix,
        nginx_prefix       => $nginx_prefix,
        mininstances       => $mininstances,
        maxpoolsize        => $maxpoolsize,
        poolidletime       => $poolidletime,
        maxinstancesperapp => $maxinstancesperapp,
        spawnmethod        => $spawnmethod,
        passenger_version  => $version,
        gempath            => $gempath,
        wrapperpath        => $wrapperpath,
        binpath            => $binpath;
      }
    }
  }
}
