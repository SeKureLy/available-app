# frozen_string_literal: true
require_relative '../init'
require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

# require_relative '../lib/scopus_api'
require_relative '../lib/mappers/paper_mapper'

RAW_CORRECT = YAML.safe_load(File.read('spec/fixtures/raw_scopus.yml'), [Symbol])
PARSE_CORRECT = YAML.safe_load(File.read('spec/fixtures/parse_scopus.yml'), [Symbol])
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['api_key']


CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'scopus_api'