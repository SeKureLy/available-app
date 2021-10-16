require 'http'
require 'yaml'
require 'google_search_results' 

config = YAML.safe_load(File.read('config/secrets.yml'))
puts config["api_key"]

params = {
  engine: "google_scholar",
  q: "biology",
  api_key: config["api_key"]
}

search = GoogleSearch.new(params)
organic_results = search.get_hash[:organic_results]
puts organic_results