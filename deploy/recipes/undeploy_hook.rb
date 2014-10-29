#
# Cookbook Name:: deploy
# Recipe:: undeploy_hook

include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  current_path = node[:deploy][application][:current_path]

  Chef::Log.info "#queueing checkdeploy hook undeploy.rb"
  instance_eval do
    Dir.chdir(current_path) do
      from_file("#{current_path}/deploy/undeploy.rb") if ::File.exist?("#{current_path}/deploy/undeploy.rb")
    end
  end
end
