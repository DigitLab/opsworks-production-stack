define :opsworks_undeploy do
  application = params[:app]
  deploy = params[:deploy_data]

  undeploy deploy[:deploy_to] do
    action :undeploy
  end
end