#
# Cookbook Name:: undeploy
# Recipe:: default
#

node[:deploy].each do |application, deploy|

  opsworks_undeploy do
    deploy_data deploy
    app application
  end

end