# frozen_string_literal: true

require 'http'
require 'json'

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
    # api_key = '2b6e002a31a702d2ff300b0c9918ad4d68a6c804e7ed7c263777d378a5893910'


    def initialize(api_key)
      @api_key = api_key
    end

    def parse()
      results = @organic_results.map do |origin_hash| {
          title: origin_hash['title'],
          link: origin_hash['link'],
          snippet: origin_hash['snippet'],
          journal: origin_hash['publication_info']['summary'].split('-')[1],
          author: origin_hash['publication_info']['summary'].split('-')[0],
          citeBy: origin_hash['inline_links']['cited_by']['total']
        } 
      end
      puts results
      # File.write('spec/test/gs_results.yml', results.to_yaml)
      results
    end

    def search(query)
      url = API_PROJECT_ROOT + "engine=google_scholar&q=#{query}&api_key=#{@api_key}"

      result = HTTP.get(url)

      puts result.code
      # puts result.parse
      # puts JSON.parse(result)['organic_results']
      # @organic_results = result.parse['organic_results'].map { |item| item.transform_keys(&:to_sym)}
      # @organic_results = result.parse['organic_results'].deep_symbolize_keys
      @organic_results = JSON.parse(result, symbolize_keys: true)
      puts @organic_results
      # my_hash.transform_keys(&:to_sym)
      # qq = result.parse['organic_results'].map{ |k, v|
      #   v
      # }
      # puts qq

      # File.write('spec/test/raw_gs_results.yml', @organic_results.to_yaml)
      successful?(result) ? @organic_results : raise(HTTP_ERROR[result.code])
    end
    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end

test = Google::ScholarApi.new('2b6e002a31a702d2ff300b0c9918ad4d68a6c804e7ed7c263777d378a5893910')
test.search("blockchain")
# puts test.parse()
#       params = {
#         engine: @engine,
#         q: query,
#         api_key: @serp_api_key
#       }
#       search = GoogleSearch.new(params)
#       # puts search
#       # successful?(@organic_results) ? @organic_results : raise(HTTP_ERROR[@organic_results.code])
#       @organic_results = search.get_hash[:organic_results]
      
#     end

#     def parse()
#       results = @organic_results.map do |origin_hash| {
#           title: origin_hash[:title],
#           link: origin_hash[:link],
#           snippet: origin_hash[:snippet],
#           journal: origin_hash[:publication_info][:summary].split('-')[1],
#           author: origin_hash[:publication_info][:summary].split('-')[0],
#           citeBy: origin_hash[:inline_links][:cited_by][:total]
#         } 
#       end
#     end

#     # def successful?(result)
#     #   !HTTP_ERROR.keys.include?(result.code)
#     # end

#   end
# end