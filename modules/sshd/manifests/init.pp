class sshd{
  package {
    "openssh-server":
      ensure => installed
  }

  monit::package { "sshd": }

  ssh_authorized_key {
    "phuongnd08@ubuntu-server":
      ensure => "present",
      type => "ssh-rsa",
      key => template("sshd/deploy_key_phuong_desktop.erb"),
      target => "/home/deploy/.ssh/authorized_keys",
      user => "deploy"
  }

  ssh_authorized_key {
    "phuongnd08@laptop":
      ensure => "present",
      type => "ssh-rsa",
      key => template("sshd/deploy_key_phuong_laptop.erb"),
      target => "/home/deploy/.ssh/authorized_keys",
      user => "deploy"
  }

  sshkey {
    "github.com":
      ensure => "present",
      type => "ssh-rsa",
      key => template("sshd/github_key.erb")
  }

  file { "/etc/ssh/ssh_known_hosts":
    mode => "0644",
    ensure => present,
    require => Sshkey["github.com"]
  }
}
