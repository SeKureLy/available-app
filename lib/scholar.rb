# frozen_string_literal: true

require 'http'

module Google
  require 'google_search_results'

  # Library for 
  class ScholarApi

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

  end
end