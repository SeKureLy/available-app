# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'



# module for calling Google API
module Elsevier
  # require 'google_search_results'
  
  # Library for Google Scholar API
  class ScopusAPI
    attr_reader :organic_results
    
    # attr_accessor :result
    # handling error
    module Errors
      # Handle not found 404
      class NotFound < StandardError; end
      # Handle not found 401
      class Unauthorized < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    API_PROJECT_ROOT = 'https://api.elsevier.com/content/search/scopus?'

    def initialize()
    end

    def parse
      organic_results.map do |origin_hash|
        {
          eid: origin_hash[:eid],
          title: origin_hash[:"dc:title"],
          link: origin_hash[:"prism:url"],
          snippet: origin_hash[:snippet],
          journal: summary[1], author: summary[0],
          citeBy: origin_hash[:inline_links][:cited_by][:total]
        }
      end
    end

    def search(query)
      config = YAML.safe_load(File.read('config/secrets.yml'))
      # api_key = config['api_key']
      # puts api_key
      field = ["authname", "dc:title", "eid", "citedby-count", "prism:url", "prism:publicationName", "prism:coverDate", "affilname"].join(',')
      url = API_PROJECT_ROOT + "query=#{query}&sort=citedby-count&count=1&filed=#{field}"
      # puts url
      result = HTTP.headers('Accept' => 'application/json',
                            'X-ELS-APIKey' => "#{config['api_key']}").get(url)
      response_code = result.code
      raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

      @organic_results = JSON.parse(result, symbolize_names: true)[:"search-results"][:entry]
      puts @organic_results
    end
  end
end

test = Elsevier::ScopusAPI.new()
test.search("blockchain")