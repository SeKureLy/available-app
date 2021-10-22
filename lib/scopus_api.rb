# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'

require_relative 'metadata'


# module for calling Google API
module Elsevier
  # require 'google_search_results'
  
  # Library for Google Scholar API
  class ScopusAPI
    attr_reader :search_result
    
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

    def search(query)
      config = YAML.safe_load(File.read('config/secrets.yml'))
      # api_key = config['api_key']
      # puts api_key
      field = ["authname", "dc:title", "eid", "citedby-count", "prism:url", "prism:publicationName", "prism:coverDate", "affilname"].join(",")
      # puts field
      url = API_PROJECT_ROOT + "query=#{query}&sort=citedby-count&count=1&field=#{field}"
      # # url = "https://api.elsevier.com/content/search/scopus?query=blockchain&sort=citedby-count&count=1&field=authname,dc:title,eid,citedby-count,prism:url,prism:publicationName,prism:coverDate,affilname"
      # puts url
      # # puts url
      result = HTTP.headers('Accept' => 'application/json',
                            'X-ELS-APIKey' => "#{config['api_key']}").get(url)
      response_code = result.code
      raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

      @search_result = JSON.parse(result, symbolize_names: true)[:"search-results"][:entry]
      PaperDeep::Matadata.new(@search_result, self)
      # puts @search_result
    end
  end
end

# test = Elsevier::ScopusAPI.new()
# test.search("blockchain")