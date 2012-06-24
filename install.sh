apt-get update
apt-get install -y git-core puppet
git clone https://github.com/phuongnd08/iRes_puppet.git
cd iRes_puppet
git submodule update --init
puppet apply --modulepath ./modules manifests/site.pp
puppet apply --modulepath ./modules manifests/site.pp
