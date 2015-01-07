class Chef
  class Resource
    class Undeploy < Chef::Resource

      provider_base Chef::Provider::Undeploy

      state_attrs :deploy_to

      def initialize(name, run_context=nil)
        super
        @resource_name = :undeploy
        @deploy_to = name
        @action = :undeploy
        @provider = Chef::Provider::Undeploy
        @allowed_actions.push(:undeploy)
      end

      def deploy_to(arg=nil)
        set_or_return(
          :deploy_to,
          arg,
          :kind_of => [ String ]
        )
      end

    end
  end
end