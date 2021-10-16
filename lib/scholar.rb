# frozen_string_literal: true

require 'http'

module Google
  require 'google_search_results'

  # Library for 
  class ScholarApi

    # module Errors
    #   class NotFound < StandardError; end
    #   class Unauthorized < StandardError; end # rubocop:disable Layout/EmptyLineBetweenDefs
    # end

    # HTTP_ERROR = {
    #   401 => Errors::Unauthorized,
    #   404 => Errors::NotFound
    # }.freeze

    def initialize(api_key)
      @engine = 'google_scholar'
      @serp_api_key = api_key
    end

    def search(query)
      params = {
        engine: @engine,
        q: query,
        api_key: @serp_api_key
      }
      search = GoogleSearch.new(params)
      # puts search
      # successful?(@organic_results) ? @organic_results : raise(HTTP_ERROR[@organic_results.code])
      @organic_results = search.get_hash[:organic_results]
      
    end

    def parse()
      results = @organic_results.map do |origin_hash| {
          title: origin_hash[:title],
          link: origin_hash[:link],
          snippet: origin_hash[:snippet],
          journal: origin_hash[:publication_info][:summary].split('-')[1],
          author: origin_hash[:publication_info][:summary].split('-')[0],
          citeBy: origin_hash[:inline_links][:cited_by][:total]
        } 
      end
    end

    # def successful?(result)
    #   !HTTP_ERROR.keys.include?(result.code)
    # end

  end
end