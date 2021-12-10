# frozen_string_literal: true

require_relative '../../init'
require 'http'

module PaperDeep
  module Gateway
    # Infrastructure to call PaperDeep API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def search(keyword)
        @request.search(keyword)
      end

      def publication(pid)
        @request.publication(pid)
      end

      def citation_tree
        @request.citation_tree
      end

      def db_paper
        @request.db_paper
      end

      def db_publication(eid)
        @request.db_publication(eid)
      end

      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config[:API_HOST]
          @api_root = "#{config[:API_HOST]}/api/v1"
        end

        def get_root # rubocop:disable Naming/AccessorMethodName
          get_api('get')
        end

        def search(keyword)
          post_api('post', ['search'],
                   'keyword' => keyword)
        end

        def publication(pid)
          post_api('post', ['publication'],
                   'pid' => pid)
        end

        def db_paper
          get_api('get', ['db'])
        end

        def db_publication(eid)
          post_api('post', ['db/eid'],
                   'eid' => eid)
        end

        def citation_tree
          get_api('get', ['citation_tree'])
        end

        private

        def get_api(method, resources = [], _params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/')

          HTTP.headers('Accept' => 'application/json').send(method, url)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end

        def post_api(_method, resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/')

          HTTP.headers('Accept' => 'application/json').post(url, body: params.to_json)
            .then { |http_response| Response.new(http_response) }
        rescue StandardError
          raise "Invalid URL request: #{url}"
        end
      end

      # Decorates HTTP responses with success/error
      class Response < SimpleDelegator
        NotFound = Class.new(StandardError)

        SUCCESS_CODES = (200..299)

        def success?
          code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
        end

        def message
          payload['message']
        end

        def payload
          body.to_s
        end
      end
    end
  end
end


# qqq = PaperDeep::Gateway::Api.new(PaperDeep::App.config)

# qqq = PaperDeep::Gateway::Api.new({ API_HOST: 'http://localhost:9292' })
# puts qqq.alive?

# puts qqq.search("iot")
# puts qqq.search('2-s2.0-84876943063')
# puts qqq.publication("84979828304")
# puts qqq.db_paper()
# puts qqq.db_publication("2-s2.0-84876943063")
