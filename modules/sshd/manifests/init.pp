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
      key => template("sshd/deploy_key.erb"),
      target => "/home/deploy/.ssh/authorized_keys",
      user => "deploy"
  }
}
