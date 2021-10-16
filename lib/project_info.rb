# frozen_string_literal: true

require 'http'
require 'yaml'
require 'google_search_results'

config = YAML.safe_load(File.read('config/secrets.yml'))

params = {
  engine: 'google_scholar',
  q: 'blockchain',
  api_key: config['api_key']
}

search = GoogleSearch.new(params)
organic_results = search.get_hash[:organic_results]

results = organic_results.map do |origin_hash|
  summary = origin_hash[:publication_info][:summary].split('-')
  {
    title: origin_hash[:title],
    link: origin_hash[:link],
    snippet: origin_hash[:snippet],
    journal: summary[1], author: summary[0],
    citeBy: origin_hash[:inline_links][:cited_by][:total]
  }
end

File.write('spec/fixtures/raw_gs_results.yml', organic_results.to_yaml)
File.write('spec/fixtures/gs_results.yml', results.to_yaml)
