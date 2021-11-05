# frozen_string_literal: true

require 'roda'
require 'slim'
require 'rack/cors'
require 'json'

module PaperDeep
  # Web App
  class App < Roda
    use Rack::Cors, debug: true, logger: Logger.new($stdout) do
      allowed_methods = %i[get post put delete options head]
      allow do
        origins '*'
        resource '*', headers: :any, methods: allowed_methods
      end
    end
    plugin :public, root: 'app/views/built', gzip: true
    # plugin :assets, js_dir:'app/views/static/js'#,css_dir:'app/views/static/css'
    plugin :halt
    route do |routing|
      #########################################
      #   For render react static files
      routing.public
      # routing.assets

      #   GET /
      routing.root do
        File.read('app/views/built/index.html')
      end

      routing.on ['test2', 'citedResult'] do
        File.read('app/views/built/index.html')
      end

      #########################################
      #   For Apis
      routing.on 'project' do
        routing.is do
          routing.get do
            scopus = PaperDeep::PaperMapper.new(App.config.api_key)
            scopus.search('blockchain')
            scopus_parse_project = scopus.parse
            scopus_parse_project.map(&:content).to_json
          end

          # POST /project/
          routing.post do
            params = JSON.parse(routing.body.read)

            scopus = PaperDeep::PaperMapper.new(App.config.api_key)
            scopus.search(params['keyword'])
            scopus_parse_project = scopus.parse

            # Add a result to database
            scopus_parse_project.map do |paper| 
              puts paper
              Repository::For.entity(paper).db_find_or_create(paper)
            end
            scopus_parse_project.map(&:content).to_json
          end
        end

        # routing.on do
        # routing.on String, String do |owner, project|
        # GET /project/owner/project
        # routing.get do
        # end
        # end
      end
      ######################################
      routing.on 'db' do
        routing.is do
          routing.get do
            paper = Repository::For.klass(Entity::Paper).all
            paper.map(&:content).to_json
          end
        end
      end
      
      #########################################
    end
  end
end
