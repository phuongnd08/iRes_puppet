class nginx {
  file {
    '/etc/init.d/nginx':
      content => template('nginx/nginx.erb'),
      mode => 0700
  }
}
