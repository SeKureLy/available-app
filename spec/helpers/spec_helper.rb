# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../../init'

ENV['RACK_ENV'] = 'test'
RAW_CORRECT = YAML.safe_load(File.read('spec/fixtures/raw_scopus.yml'), [Symbol])
PARSE_CORRECT = YAML.safe_load(File.read('spec/fixtures/parse_scopus.yml'), [Symbol])
RAW_CORRECT_PUBLICATION = YAML.safe_load(File.read('spec/fixtures/raw_scival.yml'), [Symbol])
PARSE_CORRECT_PUBLICATION = YAML.safe_load(File.read('spec/fixtures/parse_scival.yml'), [Symbol])
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['test']['api_key']
