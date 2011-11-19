class monit {
    package {
        "monit": ensure => installed;
    }

    service { "monit":
        ensure => running,
        enable => true,
        require => Package["monit"],
    }

    file {
        '/etc/monit.d':
            ensure => directory;
        '/etc/monit.conf':
            content => template('monit/monitrc.erb'),
            mode => 0600,
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
            content => template("${name}/${name}.monit.erb"),
            group => root,
            require => File['/etc/monit.d'],
            notify => Service[monit],
            mode => 0600;
    }
}
