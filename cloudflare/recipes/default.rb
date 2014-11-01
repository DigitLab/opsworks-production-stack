include_recipe 'apache2'

node[:cloudflare][:packages].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{Chef::Config['file_cache_path']}/mod_cloudflare.c" do
  source 'https://www.cloudflare.com/static/misc/mod_cloudflare/mod_cloudflare.c'
  mode '0644'
end

template "#{node['apache']['dir']}/mods-available/cloudflare.conf" do
  source 'cloudflare.conf.erb'
  owner 'root'
  group node['apache']['root_group']
  mode '0644'
  variables({
    :header => node[:cloudflare][:header],
    :trusted_proxy => node[:cloudflare][:trusted_proxy]
  })
end

link "#{node['apache']['dir']}/mods-enabled/cloudflare.conf" do
  to "#{node['apache']['dir']}/mods-available/cloudflare.conf"
  owner 'root'
  group node['apache']['root_group']
end

bash 'install-mod_cloudflare' do
  cwd "#{Chef::Config['file_cache_path']}"
  code "apxs -a -i -c mod_cloudflare.c"
  creates "#{node['apache']['libexec_dir']}/mod_cloudflare.so"
  notifies :restart, 'service[apache2]'
  not_if "test -f #{node[:apache][:libexecdir]}/mod_cloudflare.so"
end
