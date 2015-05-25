module DirectAdmin

  module Generators

    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Creates directadmin initializer"
      def copy_initializer
        template '../templates/direct_admin.rb.erb', 'config/initializers/direct_admin.rb'
      end
    end

  end

end