require 'bundler/inline'

gemfile(true) do
  source 'https://rubygems.org'

  gem 'rails', '~> 6.0.0'
  gem 'puma'
end

require 'action_controller/railtie'
require 'action_view/railtie'

class App < Rails::Application
  routes.append { root to: 'hello#world' }
  config.logger = ActiveSupport::Logger.new(STDOUT)
end

class HelloController < ActionController::Base
  prepend_view_path 'views_1'
  prepend_view_path 'views_2'

  def world
    render template: 'myview'
  end
end

App.initialize!

Rack::Server.new(app: App, Port: 4321).start
