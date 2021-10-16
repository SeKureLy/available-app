require 'http'
require 'yaml'
require 'google_search_results' 

def parse(origin_hash)
  # puts origin_hash
  return_hash = {
    title: origin_hash[:title],
    link: origin_hash[:link],
    snippet: origin_hash[:snippet],
    journal: origin_hash[:publication_info][:summary].split('-')[1],
    author: origin_hash[:publication_info][:summary].split('-')[0],
    citeBy: origin_hash[:inline_links][:cited_by][:total]
  }
  puts return_hash
end

config = YAML.safe_load(File.read('config/secrets.yml'))


params = {
  engine: "google_scholar",
  q: "blockchain",
  api_key: config["api_key"]
}

search = GoogleSearch.new(params)
organic_results = search.get_hash[:organic_results]


organic_results.each { |item|
  parse(item)
}

# results = {}
# File.write('spec/fixtures/github_results.yml', organic_results.to_yaml)