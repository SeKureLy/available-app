# frozen_string_literal: false

require_relative 'helpers/spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of API and Database' do
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

    it 'HAPPY[paper]: should be able to save paper from Scopus to database' do
      papers = PaperDeep::PaperMapper.new(API_TOKEN)
      papers.search('blockchain')
      papers_parse_result = papers.parse

      db_papers = papers_parse_result.map do |paper|
        PaperDeep::Repository::For.entity(paper).db_find_or_create(paper)
      end

      db_find_by_publication = PaperDeep::Repository::For.klass(PaperDeep::Entity::Paper).find_publication_by_id('84979828304')
      db_find_id = PaperDeep::Repository::For.klass(PaperDeep::Entity::Paper).find_eid('2-s2.0-84979828304')

      _(db_find_by_publication.eid).must_equal(db_find_id.eid)

      db_papers_all = PaperDeep::Repository::For.klass(PaperDeep::Entity::Paper).all

      _(db_papers_all[0].eid).must_equal(papers_parse_result[0].eid)
      _(db_papers_all[0].title).must_equal(papers_parse_result[0].title)
      _(db_papers_all[0].paper_link).must_equal(papers_parse_result[0].paper_link)
      _(db_papers_all[0].citedby_link).must_equal(papers_parse_result[0].citedby_link)
      _(db_papers_all[0].date).must_equal(papers_parse_result[0].date)
      _(db_papers_all[0].organization).must_equal(papers_parse_result[0].organization)
      _(db_papers_all[0].citedby).must_equal(papers_parse_result[0].citedby)
      _(db_papers_all[0].publication_id).must_equal(papers_parse_result[0].publication_id)
      _(db_papers_all[0].author).must_equal(papers_parse_result[0].author)

      _(db_papers_all[1].eid).must_equal(papers_parse_result[1].eid)
      _(db_papers_all[1].title).must_equal(papers_parse_result[1].title)
      _(db_papers_all[1].paper_link).must_equal(papers_parse_result[1].paper_link)
      _(db_papers_all[1].citedby_link).must_equal(papers_parse_result[1].citedby_link)
      _(db_papers_all[1].date).must_equal(papers_parse_result[1].date)
      _(db_papers_all[1].organization).must_equal(papers_parse_result[1].organization)
      _(db_papers_all[1].citedby).must_equal(papers_parse_result[1].citedby)
      _(db_papers_all[1].publication_id).must_equal(papers_parse_result[1].publication_id)
      _(db_papers_all[1].author).must_equal(papers_parse_result[1].author)
    end
    it 'HAPPY[publication]: should be able to save paper from Scival to database' do
      publications = PaperDeep::PublicationMapper.new(API_TOKEN)
      publications.search('84979828304')
      publications_parse_result = publications.parse

      PaperDeep::Repository::For.entity(publications_parse_result.first).db_find_or_create(publications_parse_result.first)
      db_publication = PaperDeep::Repository::For.entity(publications_parse_result.first).all.first
      _(db_publication.pid).must_equal(publications_parse_result.first.content[:pid])
      _(db_publication.journal_impact).must_equal(publications_parse_result.first.content[:journal_impact])
      _(db_publication.views_count).must_equal(publications_parse_result.first.content[:views_count])
      _(db_publication.citation_count).must_equal(publications_parse_result.first.content[:citation_count])
      _(db_publication.publication_year).must_equal(publications_parse_result.first.content[:publication_year])
      _(db_publication.source_title).must_equal(publications_parse_result.first.content[:source_title])
    end
    it 'HAPPY[paper]+[publication]: should be able to keep consistency from Paper and Publication' do
      papers = PaperDeep::PaperMapper.new(API_TOKEN)
      papers.search('blockchain')
      papers_parse_result = papers.parse

      db_papers = papers_parse_result.map do |paper|
        PaperDeep::Repository::For.entity(paper).db_find_or_create(paper)
      end

      publications = PaperDeep::PublicationMapper.new(API_TOKEN)
      publications.search('84979828304')
      publications_parse_result = publications.parse

      db_publication = PaperDeep::Repository::For.entity(publications_parse_result.first).db_find_or_create(publications_parse_result.first)

      _(db_papers[0].publication_id).must_equal(db_publication.pid)
    end
  end
end