module Quoll
  class Engine < ::Rails::Engine
    require File.dirname(__FILE__) + '/../../app/models/quoll_group.rb'
    require File.dirname(__FILE__) + '/../../app/models/quoll_query.rb'
    config.after_initialize do
      require File.dirname(__FILE__) + '/../../app/admin/quoll_group.rb'
      require File.dirname(__FILE__) + '/../../app/admin/quoll_oracle.rb'
      require File.dirname(__FILE__) + '/../../app/admin/quoll_query.rb'
    end

    initializer "engine.assets.precompile" do |app|
      app.config.assets.precompile += %w(quoll.css simple_web_buttons.css quoll.js https://www.google.com/jsapi)
      ActiveAdmin.setup do |config|
        config.register_stylesheet 'quoll.css'
        config.register_stylesheet 'simple_web_buttons.css'
        config.register_javascript 'quoll.js'
        config.register_javascript "https://www.google.com/jsapi"
      end
    end
  end
end
