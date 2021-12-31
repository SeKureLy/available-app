# frozen_string_literal: true

require 'roda'
require 'slim'
require 'rack/cors'
require 'json'

# rubocop:disable Metrics/ClassLength
module PaperDeep
  # Web App
  class App < Roda
    use Rack::Cors, debug: true, logger: Logger.new($stdout) do
      allowed_methods = %i[get post put delete options head]
      allow do
        origins 'localhost:3000'
        resource '*', headers: :any, methods: allowed_methods, credentials: true
      end
    end
    plugin :public, root: 'app/presentation/built', gzip: true
    plugin :halt
    plugin :flash
    route do |routing|
      #########################################
      #   For render react static files
      routing.public

      #   GET /
      routing.root do
        File.read('app/presentation/built/index.html')
      end

      routing.on ['test2', 'citedResult'] do
        File.read('app/presentation/built/index.html')
      end

      #########################################
      #   For Apis
      routing.on 'api/v1' do
        routing.is do
          routing.get do
            message = "PaperDeep API v1 at /api/v1/ in #{App.environment} mode"

            result_response = Representer::HttpResponse.new(
              Response::ApiResult.new(status: :ok, message: message)
            )

            api_v1_link = [
              paper: 'api/v1/paper',
              citationtree: 'api/v1/citationtree',
              publication: 'api/v1/publication',
              db_eid: 'api/v1/db/eid'
            ]

            full_response = JSON.parse(result_response.to_json)
            full_response['link'] = api_v1_link

            response.status = result_response.http_status_code
            full_response.to_json
          end
        end
        routing.on 'paper' do
          routing.is do
            # POST /search/
            routing.post do
              params = JSON.parse(routing.body.read)
              search_request = PaperDeep::Forms::NewSearch.new.call(params)
              result = PaperDeep::Service::AddPaper.new.call(search_request)

              if result.failure?
                flash[:error] = result.failure
                return { result: false, error: flash[:error] }.to_json
              end
              paper_list = Representer::Papers.new(result.value!['keyword'], result.value!['paper'])
              return Representer::PaperList.new(paper_list).to_json
            end
          end
        end
        routing.on 'publication' do
          routing.is do
            # POST /search/publication
            routing.post do
              params = JSON.parse(routing.body.read)
              result = PaperDeep::Service::SearchPublication.new.call(params)

              if result.failure?
                flash[:error] = result.failure
                return { result: false, error: flash[:error] }.to_json
              end

              # puts result.value!
              if result.value![:publication].empty?
                return { result: false, error: 'Publication search result is nil' }.to_json
              end

              # Views::Publications.new(result.value![:publication]).content.to_json
              publication_list = Representer::Publications.new(result.value![:publication])
              # publication_list = OpenStruct.new(publication: result.value![:publication])
              # puts publication_list
              Representer::PublicationList.new(publication_list).to_json
            end
          end
        end
        routing.on 'citationtree' do
          routing.is do
            # GET /search/citationtree
            routing.get do
              root_paper = session[:paper].first

              result = PaperDeep::Service::CitationTree.new.call(root_paper)

              puts result.value!.to_json

              if result.failure?
                flash[:error] = result.failure
                return { result: false, error: flash[:error] }.to_json
              end

              result.value!.to_json
            end
          end
        end
        ######################################
        routing.on 'db' do
          routing.is do
            # GET /db/
            routing.get do
              paper = JSON.parse(Gateway::Api.new(App.config).db_paper)
              paper.to_json
            end
          rescue StandardError
            flash[:error] = 'Having trouble getting papers from database'
            return { result: false, error: flash[:error] }.to_json
          end
          routing.on 'eid' do
            routing.is do
              # POST /db/eid
              routing.post do
                session.clear
                session[:paper] ||= []
                params = JSON.parse(routing.body.read)

                paper = JSON.parse(Gateway::Api.new(App.config).db_publication(params['eid']))

                if paper.nil?
                  return { result: false,
                           error: 'Having trouble getting publication from database' }.to_json
                end

                session[:paper].insert(0, paper)
                paper.to_json
              end
            end
          end
        end
      end
      #########################################
    end
  end
end
# rubocop:enable Metrics/ClassLength
