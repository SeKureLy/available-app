# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'


# module for the paperdeep project 
module PaperDeep

  # class for the scopus API
  class ScopusAPI
    attr_reader :search_result, :uri

    # handling error
    module Errors
      # Handle not found 404
      class NotFound < StandardError; end
      # Handle unauthorized 401
      class Unauthorized < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze


    def initialize(api_key)
      @api_key = api_key
    end

    def write_uri(uri)
      @uri = uri
    end

    def make_uri(query)
      uri = URI('https://api.elsevier.com/content/search/scopus?')
      params = {
        query: query,
        count: 2,
        sort: 'citedby-count'
        # field: ['dc:creator', 'dc:title', 'eid', 'citedby-count', 'prism:url', 'prism:publicationName',
        #         'prism:coverDate', 'affilname'].join(',')
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
# tmp = test.search("blockchain")
# # puts tmp[:link].select { |item| item[:@ref] == 'scopus-citedby'}
# a = tmp[0][:link].select { |item| item[:@ref] == 'scopus-citedby'}
# puts a[0][:@href]