#
# Cookbook Name:: composer
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#

include_recipe "php"

#install/upgrade curl
package "curl" do
	action :upgrade
end

command = "curl -s https://getcomposer.org/installer | php"

unless node[:composer][:install_globally]
	unless node[:composer][:install_dir].nil? || node[:composer][:install_dir].empty?
		command = command + " -- --install-dir=#{node[:composer][:install_dir]}"
    end
end

Chef::Log.debug("Installing composer")

bash "download_composer" do
	cwd "#{Chef::Config[:file_cache_path]}"
	code <<-EOH
		#{command}
	EOH
end

if node[:composer][:install_globally]
	bash "move_composer" do
		cwd "#{Chef::Config[:file_cache_path]}"
		code <<-EOH
			sudo mv composer.phar #{node[:composer][:prefix]}/bin/composer
		EOH
	end
end

unless node[:composer][:github_oauth].nil? || node[:composer][:github_oauth].empty?
	Chef::Log.debug("Adding github client secret")
	bash "config_composer" do
		code <<-EOH
			composer config -g github-oauth.github.com #{node[:composer][:github_oauth]}
		EOH
	end
end
