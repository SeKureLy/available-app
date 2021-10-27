# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'

# require_relative 'metadata'

# module for calling Google API
module PaperDeep
#   require_relative 'paper'

  # Library for Google Scholar API
  class ScopusAPI
    attr_reader :search_result, :uri

    # attr_accessor :uri
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

    def initialize(api_key)
      @api_key = api_key
    end

    # def parse
    #   search_result.map do |origin_hash|
    #     PaperDeep::PaperInfo.new(origin_hash).content
    #   end
    # end

    def write_uri(uri)
      @uri = uri
    end

    def make_uri(query)
      uri = URI('https://api.elsevier.com/content/search/scopus?')
      params = {
        query: query,
        sort: 'citedby-count',
        field: ['dc:creator', 'dc:title', 'eid', 'citedby-count', 'prism:url', 'prism:publicationName',
                'prism:coverDate', 'affilname'].join(',')
      }
      uri.query = URI.encode_www_form(params)
      write_uri(uri)
    end

    def search(query)
      make_uri(query)
      result = HTTP.headers('Accept' => 'application/json',
                            'X-ELS-APIKey' => @api_key.to_s).get(uri)
      response_code = result.code
      raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

      @search_result = JSON.parse(result, symbolize_names: true)[:'search-results'][:entry]
    end
  end
end

# test = PaperDeep::ScopusAPI.new('c04c47e12dff67bb111f066d47f54115')
# test.search("blockchain")
# puts test.parse()
