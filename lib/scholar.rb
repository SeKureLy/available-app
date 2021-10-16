# frozen_string_literal: true

require 'http'
require 'json'

# module for calling Google API
module Google
  require 'google_search_results'

  # Library for
  class ScholarApi
    module Errors
      class NotFound < StandardError; end
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
      @organic_results.map do |origin_hash|
        summary = origin_hash[:publication_info][:summary].split('-')
        return_hash = 
        {
          title: origin_hash[:title],
          link: origin_hash[:link],
          snippet: origin_hash[:snippet],
          journal: summary[1],
          author: summary[0],
          citeBy: origin_hash[:inline_links][:cited_by][:total]
        }
      end
    end

    def search(query)
      url = API_PROJECT_ROOT + "engine=google_scholar&q=#{query}&api_key=#{@api_key}"

      result = HTTP.get(url)

      @organic_results = JSON.parse(result, symbolize_names: true)[:organic_results]

      successful?(result) ? @organic_results : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
