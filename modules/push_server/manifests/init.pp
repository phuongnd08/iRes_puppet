class push_server {
  include rvm
  include rvm_ruby
  if ($rvm_installed == "true") {
    $ruby_version = "1.9.3-p125"
    class {
      "rvm_ruby::ruby":
        ruby_version => $ruby_version,
        stage => "ruby";
      "push_server::wrapper":
        ruby_version => $ruby_version,
        stage => "post-ruby";
    }
    $gemset = "${ruby_version}@push_app"
    $rvmshell = "/usr/local/rvm/bin/rvm-shell"
    monit::package {
      "push_server":
        content => template("push_server/push_server.monit.erb")
    }
  }
}

