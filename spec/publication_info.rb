# frozen_string_literal: true

require_relative 'helpers/spec_helper'

# CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
# API_TOKEN = CONFIG['api_key']

# #Publication info
instance = PaperDeep::PublicationMapper.new(API_TOKEN)

raw_data = instance.search('84979828304')
File.write('spec/fixtures/raw_scival.yml', raw_data.to_yaml)

parsed_data = instance.parse
result = parsed_data.map(&:content)
File.write('spec/fixtures/parse_scival.yml', result.to_yaml)