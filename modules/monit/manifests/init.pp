class monit {
    $configdir = "/etc/monit.d"
    case $operatingsystem {
        'CentOS': { $config = "/etc/monit.conf" }
        default: { fail("\$operatingsystem of ${fqdn} is not recognized ( '${operatingsystem}' ). ") }
    }

    package {
        "monit": ensure => installed;
    }

    service { monit:
        ensure => running,
        require => Package["monit"],
        provider => init;
    }

    file {
        '/etc/monit.d':
            ensure => directory;
        '/etc/monit.conf':
            content => template('monit/monitrc.erb'),
            mode => 0400,
            group => root,
            require => File['/etc/monit.d'],
            before => Service[monit],
            notify => Service[monit],
    }
}

define monit::package()
{
    file { $name:
            path => "/etc/monit.d/${name}.conf",
            ensure => present,
            content => template("monit/${name}.conf.erb"),
            group => root,
            require => File['/etc/monit.d'],
            notify => Service[monit],
            mode => 0400;
    }
}
