# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/scopus_api'

RAW_CORRECT = YAML.safe_load(File.read('spec/fixtures/raw_scopus.yml'), [Symbol])
PARSE_CORRECT = YAML.safe_load(File.read('spec/fixtures/parse_scopus.yml'), [Symbol])
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['api_key']

API = PaperDeep::ScopusAPI.new(API_TOKEN)

describe 'Tests Scopus API library' do
  before do
    @search_result = API.search('blockchain')
  end
  describe 'Check Raw Search Result' do
    it 'HAPPY: should provide correct length' do
      _(@search_result.size).must_equal RAW_CORRECT.size
    end
    it 'HAPPY: title should be blockchain' do
      _(@search_result[0][:"dc:title"]).must_equal RAW_CORRECT[0][:"dc:title"]
    end
    it 'HAPPY: eid should be same' do
      _(@search_result[0][:eid]).must_equal RAW_CORRECT[0][:eid]
    end
    it 'HAPPY: cite-by-count should be same' do
      _(@search_result[0][:"citedby-count"]).must_equal RAW_CORRECT[0][:"citedby-count"]
    end
  end
end

# describe 'Check Parse Search Result' do
#   before do
#     @api_instance = Google::ScholarApi.new(API_TOKEN)
#     @api_instance.search('Blockchain')
#     @parse_result = @api_instance.parse
#   end
#   it 'HAPPY: should provide correct length' do
#     _(@parse_result.size).must_equal PARSE_CORRECT.size
#   end
#   it 'HAPPY: title should be blockchain' do
#     _(@parse_result[0][:title]).must_equal RAW_CORRECT[0][:title]
#   end
#   it 'HAPPY: position should be filtered' do
#     _(assert_nil(@parse_result[0][:position]))
#   end
# end

# describe 'Error handling' do
#   it 'should raise unauthorized' do
#     _(proc do
#         Google::ScholarApi.new('bad token').search('Blockchain')
#       end).must_raise Google::ScholarApi::Errors::Unauthorized
#   end
# end
