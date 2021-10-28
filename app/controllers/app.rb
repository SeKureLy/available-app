# frozen_string_literal: true

require 'roda'
require 'slim'
require 'rack/cors'
require 'json'

module PaperDeep
  # Web App
  class App < Roda
    use Rack::Cors, debug: true, logger: Logger.new(STDOUT) do
      allowed_methods = %i[get post put delete options head]
      allow do
        origins '*'
        resource '*', headers: :any, methods: allowed_methods
      end
    end
    plugin :public, root: "app/views" , gzip: true
    plugin :assets, js_dir:'app/views/static/js'#,css_dir:'app/views/static/css'
    plugin :halt
    route do |routing|
    #########################################
    #   For render react static files
        routing.public
        routing.assets
    
    #   GET /
        routing.get ["","test2"] do
          File.read("app/views/index.html")
        end

    #########################################
    #   For Apis
        routing.on 'project' do
          routing.is do
            # POST /project/
            routing.post do
              params = JSON.parse(routing.body.read)
              return params["test_url"]
            end
          end

          routing.on String, String do |owner, project|
            # GET /project/owner/project
            routing.get do
              "#{owner}/#{project}"
            end
          end
        end
    #########################################    
    end
  end
end