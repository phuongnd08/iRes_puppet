class sshd{
  package {
    "openssh-server":
      ensure => installed
  }

  monit::package { "sshd": }

  $phuong_laptop_key = "AAAAB3NzaC1yc2EAAAADAQABAAABAQDL4gLxbzOxFtNXQxCXYA3SKin9Q5t/Onngi8SUiJnu2EhTQEOX//RUPpwtWwSUnNyOueEIfjtCPd/A1IG3YWTawD8OL14ZprciWZuYBtjj1PkEbZByq5PHdyENp+kVw8QspS3f+xViSLG2gW026pj7YU7kBKEvTIc7/ZPbnUYDWU528ARyVoq1lfbmmg0Jbc3szL3VIYQwclJtClkx7N4UX56ESAFTw6aHlsgzV993WjVq4KT7BwwKbv7MKJjNr3MlU76QjWmN4MxWxH+9bVj6QzdzB246/4SfHwZlUK/j+LHFzv2pFH/0Q6jLrMqdpvT+Hgy6caQ6V3CXsbBo5ayj"
  $github_deploy_key = "AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="

  ssh_authorized_key {
    "phuongnd08@laptop":
      ensure => "present",
      type => "ssh-rsa",
      key => $phuong_laptop_key,
      target => "/home/deploy/.ssh/authorized_keys",
      user => "deploy"
  }

  sshkey {
    "github.com":
      ensure => "present",
      type => "ssh-rsa",
      key => $github_deploy_key
  }

  file { "/etc/ssh/ssh_known_hosts":
    mode => "0644",
    ensure => present,
    require => Sshkey["github.com"]
  }
}
