# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/vcr_helper'
require_relative '../../helpers/database_helper'

describe 'Add_Paper Service Integration Test' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to find and save remote paper to database' do
      # GIVEN: a valid url request for an existing remote project:
      papers = PaperDeep::PaperMapper.new(API_TOKEN)
      papers.search(KEYWORD)
      papers_parse_result = papers.parse

      search_request = PaperDeep::Forms::NewSearch.new.call({'keyword': KEYWORD})
      # WHEN: the service is called with the request form object
      result = PaperDeep::Service::AddPaper.new.call(search_request)

      # THEN: the result should report success..
      _(result.success?).must_equal true

      # ..and provide a project entity with the right details
      rebuilt = result.value![:storage]
      _(rebuilt[0].eid).must_equal(papers_parse_result[0].eid)
      _(rebuilt[0].title).must_equal(papers_parse_result[0].title)
      _(rebuilt[0].paper_link).must_equal(papers_parse_result[0].paper_link)
      _(rebuilt[0].citedby_link).must_equal(papers_parse_result[0].citedby_link)
      _(rebuilt[0].date).must_equal(papers_parse_result[0].date)
      _(rebuilt[0].organization).must_equal(papers_parse_result[0].organization)
      _(rebuilt[0].citedby).must_equal(papers_parse_result[0].citedby)
      _(rebuilt[0].publication_id).must_equal(papers_parse_result[0].publication_id)
      _(rebuilt[0].author).must_equal(papers_parse_result[0].author)
    end

    it 'HAPPY: should find and return existing paper in database' do
      # GIVEN: a valid url request for a project already in the database:
      search_request = PaperDeep::Forms::NewSearch.new.call({'keyword': KEYWORD})
      db_paper = PaperDeep::Service::AddPaper.new.call(search_request).value![:storage]

      # WHEN: the service is called with the request form object
      result = PaperDeep::Service::AddPaper.new.call(search_request)

      # THEN: the result should report success..
      _(result.success?).must_equal true

      # ..and find the same project that was already in the database
      rebuilt = result.value![:paper]
      _(rebuilt.size).must_equal(db_paper.size)

      # ..and provide a project entity with the right details
      _(rebuilt[0].eid).must_equal(db_paper[0].eid)
      _(rebuilt[0].title).must_equal(db_paper[0].title)
      _(rebuilt[0].paper_link).must_equal(db_paper[0].paper_link)
      _(rebuilt[0].citedby_link).must_equal(db_paper[0].citedby_link)
      _(rebuilt[0].date).must_equal(db_paper[0].date)
      _(rebuilt[0].organization).must_equal(db_paper[0].organization)
      _(rebuilt[0].citedby).must_equal(db_paper[0].citedby)
      _(rebuilt[0].publication_id).must_equal(db_paper[0].publication_id)
      _(rebuilt[0].author).must_equal(db_paper[0].author)
    end

    it 'BAD: should gracefully fail for invalid keyword' do
      # GIVEN: an invalid keyword request is formed
      BAD_KEYWORD = '大笨狗'
      search_request = PaperDeep::Forms::NewSearch.new.call({'keyword': BAD_KEYWORD})

      # WHEN: the service is called with the request form object
      result = PaperDeep::Service::AddPaper.new.call(search_request)

      # THEN: the service should report failure with an error message
      _(result.success?).must_equal false
      _(result.failure.downcase).must_include 'trouble'
    end
  end
end