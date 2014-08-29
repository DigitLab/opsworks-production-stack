include_recipe 'apache2'

# add repository for PHP 5.4
apt_repository "php56" do
  uri "http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end
 
# update apt info
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
end
 
node[:mod_php5_apache2][:packages].each do |pkg|
  package pkg do
    action :install
    ignore_failure(pkg.to_s.match(/^php-pear-/) ? true : false) # some pear packages come from EPEL which is not always available
  end
end

include_recipe 'apache2::mod_php5'
