require 'rails/generators'




    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates directadmin initializer"
      def copy_initializer
        template 'direct_admin.rb', 'config/initializers/direct_admin.rb'
      end
    end



