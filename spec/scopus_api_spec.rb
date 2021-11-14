# frozen_string_literal: true

require_relative 'helpers/spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

API = PaperDeep::PaperMapper.new(API_TOKEN)

describe 'Tests Scopus API library with cassette' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Tests Scopus API library' do
    before do
      @search_result = API.search('blockchain')
    end
    describe 'Check Raw Search Result' do
      it '[raw]HAPPY: should provide correct length' do
        _(@search_result.size).must_equal RAW_CORRECT.size
      end
      it '[raw]HAPPY: title should be blockchain' do
        _(@search_result[0][:'dc:title']).must_equal RAW_CORRECT[0][:'dc:title']
      end
      it '[raw]HAPPY: eid should be same' do
        _(@search_result[0][:eid]).must_equal RAW_CORRECT[0][:eid]
      end
      it '[raw]HAPPY: cite-by-count should be same' do
        _(@search_result[0][:'citedby-count']).must_equal RAW_CORRECT[0][:'citedby-count']
      end
    end
  end

  describe 'Check Parse Search Result' do
    before do
      API.search('blockchain')
      @parse_result = API.parse
    end
    it '[parse]HAPPY: should provide correct length' do
      _(@parse_result.size).must_equal PARSE_CORRECT.size
    end
    it '[parse]HAPPY: title should be blockchain' do
      _(@parse_result[0].title).must_equal PARSE_CORRECT[0][:title]
    end
    it '[parse]HAPPY: author should be blockchain' do
      _(@parse_result[0].author).must_equal PARSE_CORRECT[0][:author]
    end
    it '[parse]HAPPY: prism:url should be parsed to link, so it is nil' do
      _(assert_nil(defined?(@parse_result[0].url)))
    end
  end

  describe 'Error handling' do
    it 'should raise unauthorized' do
      _(proc do
          PaperDeep::ScopusAPI.new('bad token').search('Blockchain')
        end).must_raise PaperDeep::ScopusAPI::Errors::Unauthorized
    end
  end
end
