# frozen_string_literal: true

require 'http'
require 'yaml'
require 'google_search_results'

def parse(origin_hash)
  return_hash = {
    title: origin_hash[:title],
    link: origin_hash[:link],
    snippet: origin_hash[:snippet],
    journal: origin_hash[:publication_info][:summary].split('-')[1],
    author: origin_hash[:publication_info][:summary].split('-')[0],
    citeBy: origin_hash[:inline_links][:cited_by][:total]
  }
end

config = YAML.safe_load(File.read('config/secrets.yml'))

params = {
  engine: 'google_scholar',
  q: 'blockchain',
  api_key: config['api_key']
}

search = GoogleSearch.new(params)
organic_results = search.get_hash[:organic_results]

results = organic_results.map { |item| parse(item) }

File.write('spec/fixtures/gh_results.yml', results.to_yaml)
