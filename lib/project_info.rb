# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'

require_relative 'paper'

config = YAML.safe_load(File.read('config/secrets.yml'))

uri = URI('https://api.elsevier.com/content/search/scopus?')
params = {
  query: 'blockchain',
  sort: 'citedby-count',
  field: ['dc:creator', 'dc:title', 'eid', 'citedby-count', 'prism:url', 'prism:publicationName', 'prism:coverDate',
          'affilname'].join(',')
}
uri.query = URI.encode_www_form(params)
# print uri

result = HTTP.headers('Accept' => 'application/json',
                      'X-ELS-APIKey' => (config['api_key']).to_s).get(uri)

search_result = JSON.parse(result, symbolize_names: true)[:'search-results'][:entry]

parse_result = search_result.map do |origin_hash|
  # author_list = origin_hash[:author].map { |item| item[:authname]}
  PaperDeep::PaperInfo.new(origin_hash).content
  # {
  #   eid: origin_hash[:eid],
  #   title: origin_hash[:"dc:title"],
  #   link: origin_hash[:"prism:url"],
  #   publicationName: origin_hash[:"prism:publicationName"],
  #   date: origin_hash[:"prism:coverDate"],
  #   Organization: origin_hash[:affiliation][0][:affilname],
  #   citeBy: origin_hash[:"citedby-count"],
  #   author: origin_hash[:"dc:creator"]
  # }
end

File.write('spec/fixtures/raw_scopus.yml', search_result.to_yaml)
File.write('spec/fixtures/parse_scopus.yml', parse_result.to_yaml)
