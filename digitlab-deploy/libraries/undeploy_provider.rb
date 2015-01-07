require "chef/mixin/from_file"

class Chef
  class Provider
    class Undeploy < Chef::Provider

      include Chef::Mixin::FromFile

      attr_reader :current_path

      def whyrun_supported?
        true
      end

      def load_current_resource
        @current_path = @new_resource.deploy_to + "/current"
      end

      def action_undeploy
        run_callback_from_file("#{current_path}/deploy/undeploy.rb")
      end

      protected

      def run_callback_from_file(callback_file)
        Chef::Log.info "#{@new_resource} queueing checkdeploy hook #{callback_file}"
        recipe_eval do
          Dir.chdir(current_path) do
            from_file(callback_file) if ::File.exist?(callback_file)
          end
        end
      end

    end
  end
end