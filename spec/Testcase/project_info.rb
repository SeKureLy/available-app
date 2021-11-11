# frozen_string_literal: true

require_relative '../../init'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['api_key']

instance = PaperDeep::PaperMapper.new(API_TOKEN)

raw_data = instance.search('blockchain')
File.write('spec/fixtures/raw_scopus.yml', raw_data.to_yaml)

parsed_data = instance.parse
result = parsed_data.map(&:content)
File.write('spec/fixtures/parse_scopus.yml', result.to_yaml)
