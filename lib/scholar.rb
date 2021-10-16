# frozen_string_literal: true

require 'http'
require 'json'

# module for calling Google API
module Google
  require 'google_search_results'

  # Library for Google Scholar API
  class ScholarApi
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

    API_PROJECT_ROOT = 'https://serpapi.com/search.json?'

    def initialize(api_key)
      @api_key = api_key
    end

    def parse
      organic_results.map do |origin_hash|
        summary = origin_hash[:publication_info][:summary].split('-')
        {
          title: origin_hash[:title],
          link: origin_hash[:link],
          snippet: origin_hash[:snippet],
          journal: summary[1], author: summary[0],
          citeBy: origin_hash[:inline_links][:cited_by][:total]
        }
      end
    end

    def search(query)
      url = API_PROJECT_ROOT + "engine=google_scholar&q=#{query}&api_key=#{@api_key}"
      result = HTTP.get(url)
      response_code = result.code
      raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

      @organic_results = JSON.parse(result, symbolize_names: true)[:organic_results]
    end
  end
end
