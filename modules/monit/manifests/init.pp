class monit {
  package {
    "monit": ensure => installed;
  }

  service { "monit":
    ensure => running,
    enable => true,
    require => Package["monit"]
  }

  monit::package {
    "httpd":
      content => template("monit/httpd.monit.erb")
  }
}

define monit::package(
  $content = false
){
  if ($content == false) {
    $monit_content = template("${name}/${name}.monit.erb")
  } else {
    $monit_content = $content
  }

  file {
    $name:
      path => "/etc/monit/conf.d/${name}.conf",
      ensure => present,
      content => $monit_content,
      group => root,
      require => Package[monit],
      notify => Service[monit],
      mode => 0600;
  }
}
