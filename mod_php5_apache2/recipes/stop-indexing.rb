template "#{node['apache']['dir']}/robots.txt" do
  source 'robots.txt.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template "#{node['apache']['conf_available_dir']}/staging.conf" do
  source 'staging.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    :path => node['apache']['dir']
  })
end