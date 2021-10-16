# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/scholar'

RAW_CORRECT = YAML.safe_load(File.read('spec/fixtures/raw_gs_results.yml'), [Symbol])
PARSE_CORRECT = YAML.safe_load(File.read('spec/fixtures/gs_results.yml'), [Symbol])
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
SERP_API_TOKEN = CONFIG['api_key']

API = Google::ScholarApi.new(SERP_API_TOKEN)

describe 'Tests Google Scholar API library' do
  before do
    @search_result = API.search('blockchain')
  end
  describe 'Check Raw Search Result' do
    it 'HAPPY: should provide correct length' do
      _(@search_result.size).must_equal RAW_CORRECT.size
    end
    it 'HAPPY: title should be blockchain' do
      _(@search_result[0][:title]).must_equal RAW_CORRECT[0][:title]
    end
    it 'HAPPY: position should be same' do
      _(@search_result[0][:position]).must_equal RAW_CORRECT[0][:position]
    end
  end

  describe 'Check Parse Search Result' do
    before do
      @parse_result = API.parse
    end
    it 'HAPPY: should provide correct length' do
      _(@parse_result.size).must_equal PARSE_CORRECT.size
    end
    it 'HAPPY: title should be blockchain' do
      _(@parse_result[0][:title]).must_equal RAW_CORRECT[0][:title]
    end
    it 'HAPPY: position should be filtered' do
      _(@parse_result[0][:position]).must_equal nil
    end
  end
end
