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
    plugin :public, root: "app/views/built" , gzip: true
    # plugin :assets, js_dir:'app/views/static/js'#,css_dir:'app/views/static/css'
    plugin :halt
    route do |routing|
    #########################################
    #   For render react static files
        routing.public
        # routing.assets
    
    #   GET /
        routing.get ["","test2"] do
          File.read("app/views/built/index.html")
        end

    #########################################
    #   For Apis
        routing.on 'project' do
          routing.is do
            routing.get do
              scopus = PaperDeep::PaperMapper.new(API_TOKEN)
              scopus.search('blockchain')
              scopus_parse_project = scopus.parse
              scopus_parse_project.map do | paper|
                paper.content
              end.to_json
            end

            # POST /project/
            routing.post do
              params = JSON.parse(routing.body.read)
    
              scopus = PaperDeep::PaperMapper.new(API_TOKEN)
              scopus.search(params["keyword"])
              scopus_parse_project = scopus.parse
              scopus_parse_project.map do | paper|
                paper.content
              end.to_json
            end
          end

          routing.on do
          # routing.on String, String do |owner, project|
            # GET /project/owner/project
            # routing.get do
            #   # "#{owner}/#{project}"
            #   scopus_project = PaperDeep::PaperMapper
            #   .new(c04c47e12dff67bb111f066d47f54115)
            #   .search('blockchain')
            # end
          end
        end
    #########################################    
    end
  end
end