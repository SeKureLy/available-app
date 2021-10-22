# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'

# require_relative 'metadata'


# module for calling Google API
module PaperDeep
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

    def initialize(api_key)
      @api_key = api_key
    end

    def parse
      search_result.map do |origin_hash|
        # author_list = origin_hash[:author].map { |item| item[:authname]}
        {
          eid: origin_hash[:eid],
          title: origin_hash[:"dc:title"],
          link: origin_hash[:"prism:url"],
          publicationName: origin_hash[:"prism:publicationName"],
          date: origin_hash[:"prism:coverDate"],
          Organization: origin_hash[:affiliation][0][:affilname],
          citeBy: origin_hash[:"citedby-count"],
          author: origin_hash[:"dc:creator"]
        }
      end
    end

    def search(query)
      # field = ["dc:creator", "dc:title", "eid", "citedby-count", "prism:url", "prism:publicationName", "prism:coverDate", "affilname"].join(",")
      # # puts field
      # url = API_PROJECT_ROOT + "query=#{query}&sort=citedby-count&field=#{field}"

      uri = URI('https://api.elsevier.com/content/search/scopus?')
      params = { 
        query: 'blockchain', 
        sort: 'citedby-count',
        field: ["dc:creator", "dc:title", "eid", "citedby-count", "prism:url", "prism:publicationName", "prism:coverDate", "affilname"].join(",")
      }
      uri.query = URI.encode_www_form(params)
      # # url = "https://api.elsevier.com/content/search/scopus?query=blockchain&sort=citedby-count&count=1&field=authname,dc:title,eid,citedby-count,prism:url,prism:publicationName,prism:coverDate,affilname"
      # puts url
      # # puts url
      result = HTTP.headers('Accept' => 'application/json',
                            'X-ELS-APIKey' => "#{@api_key}").get(uri)
      response_code = result.code
      raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

      @search_result = JSON.parse(result, symbolize_names: true)[:"search-results"][:entry]
      # PaperDeep::Matadata.new(@search_result, self)
      # puts @search_result
    end
  end
end

# test = Elsevier::ScopusAPI.new('c04c47e12dff67bb111f066d47f54115')
# test.search("blockchain")
# puts test.parse()