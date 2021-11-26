# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/vcr_helper'
require_relative '../../helpers/database_helper'

SCIVAL_API = PaperDeep::PublicationMapper.new(API_TOKEN)

describe 'Tests Scival API library for publication info with cassette' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr
    DatabaseHelper.wipe_database
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Tests Scival API library' do
    before do
      @search_result = SCIVAL_API.search('84979828304')
    end
    describe 'Check Raw Search Result' do
      it '[raw]HAPPY: should provide correct length' do
        _(@search_result.size).must_equal RAW_CORRECT_PUBLICATION.size
      end
      it '[raw]HAPPY: journal impact should be 3.5' do
        _(@search_result[0][:metrics][1][:value]).must_equal RAW_CORRECT_PUBLICATION[0][:metrics][1][:value]
      end
      it '[raw]HAPPY: sourceTitle should be same' do
        _(@search_result[0][:publication][:sourceTitle])
          .must_equal RAW_CORRECT_PUBLICATION[0][:publication][:sourceTitle]
      end
      it '[raw]HAPPY: publicationYear should be same' do
        _(@search_result[0][:publication][:publicationYear])
          .must_equal RAW_CORRECT_PUBLICATION[0][:publication][:publicationYear]
      end
    end
  end

  describe 'Check Parse Search Result' do
    before do
      SCIVAL_API.search('84979828304')
      @parse_result = SCIVAL_API.parse
    end
    it '[parse]HAPPY: should provide correct length' do
      _(@parse_result.size).must_equal PARSE_CORRECT_PUBLICATION.size
    end
    it '[parse]HAPPY: pid should be the same' do
      _(@parse_result[0].pid).must_equal PARSE_CORRECT_PUBLICATION[0][:pid]
    end
    it '[parse]HAPPY: citation count should be the same' do
      _(@parse_result[0].citation_count).must_equal PARSE_CORRECT_PUBLICATION[0][:citation_count]
    end
    it '[parse]HAPPY: publication link should be parsed into nil' do
      _(assert_nil(defined?(@parse_result[0][:publication][:link])))
    end
  end

  describe 'Error handling' do
    it 'should raise unauthorized' do
      _(proc do
          PaperDeep::PublicationAPI.new('bad token').search('84979828304')
        end).must_raise PaperDeep::PublicationAPI::Errors::Unauthorized
    end
  end
end
