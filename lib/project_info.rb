# frozen_string_literal: true

require 'http'
require 'json'
require 'yaml'


config = YAML.safe_load(File.read('config/secrets.yml'))
# api_key = config['api_key']
# puts api_key
field = ["authname", "dc:title", "eid", "citedby-count", "prism:url", "prism:publicationName", "prism:coverDate", "affilname"].join(",")
# puts field
url = API_PROJECT_ROOT + "query=#{query}&sort=citedby-count&field=#{field}"
# # url = "https://api.elsevier.com/content/search/scopus?query=blockchain&sort=citedby-count&count=1&field=authname,dc:title,eid,citedby-count,prism:url,prism:publicationName,prism:coverDate,affilname"
# puts url
# # puts url
result = HTTP.headers('Accept' => 'application/json',
                      'X-ELS-APIKey' => "#{config['api_key']}").get(url)
response_code = result.code
raise(HTTP_ERROR[response_code]) if HTTP_ERROR.keys.include?(response_code)

search_result = JSON.parse(result, symbolize_names: true)[:"search-results"][:entry]


search_result.map do |origin_hash|
  author_list = origin_hash[:author].map { |item| item[:authname]}
  {
    eid: origin_hash[:eid],
    title: origin_hash[:"dc:title"],
    link: origin_hash[:"prism:url"],
    publicationName: origin_hash[:"prism:publicationName"],
    date: origin_hash[:"prism:coverDate"],
    Organization: origin_hash[:affiliation][0][:affilname],
    citeBy: origin_hash[:"citedby-count"],
    author: author_list.join(",")
  }
end

puts search_result

